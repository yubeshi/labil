class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]

  # GET /schedules.json
  def index
    @schedules = Schedule.all
  end

  # GET /schedules/1
  # GET /schedules/1.json
  def show
  end

  # GET /schedules/new
  def new
    @schedule = Schedule.new
  end

  # GET /schedules/1/edit
  def edit
    #render :text=>'edit'
  end
  
  

  # POST /schedules
  # POST /schedules.json
  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.flag=3 # その他
    cemester=@schedule.event_end - @schedule.event_start
    
    #dayly
    if (cemester/86400).to_i == 0 then
      @schedule.flag=1    
    else
    end
    #weekly
    if (cemester/86400).to_i == 7 then
      @schedule.flag=2
    else
    end
    
    respond_to do |format|

      if @schedule.save
        format.html { redirect_to @schedule, notice: 'Schedule was successfully created.' }
        format.json { render :show, status: :created, location: @schedule }
      else
        format.html { render :new }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schedules/1
  # PATCH/PUT /schedules/1.json
  def update
    
    #@schedule.flag=5
    
    respond_to do |format|
      cemester=@schedule.event_end - @schedule.event_start
      #dayly
      if (cemester/86400).to_i == 0 then
        @schedule.flag=1
      else        
      end            
      #weekly
      if (cemester/86400).to_i == 7 then
        @schedule.flag=2
      else        
      end

           
      if @schedule.update(schedule_params)      
        format.html { redirect_to @schedule, notice: 'Schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @schedule }
      else
        format.html { render :edit }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.json
  def destroy
    @schedule.destroy
    respond_to do |format|
      format.html { redirect_to schedules_url, notice: 'Schedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  

  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    def schedule_params   
      params.require(:schedule).permit(:member_id, :event_start, :event_end, :venue, :flag)
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    #def schedule_params
    #  params.require(:schedule).permit(:member_id, :event_start, :event_end, :venue)
    #end
    
    
end

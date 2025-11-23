type CheckIn struct {
    id      int
    station string
    time    int
}

type Travel struct {
    totalTime int
    count     int
}

type UndergroundSystem struct {
    checkIns   map[int]CheckIn
    travelData map[string]Travel
}

func Constructor() UndergroundSystem {
    return UndergroundSystem{
        checkIns:   make(map[int]CheckIn),
        travelData: make(map[string]Travel),
    }
}

func (this *UndergroundSystem) CheckIn(id int, stationName string, t int) {
    this.checkIns[id] = CheckIn{id, stationName, t}
}

func (this *UndergroundSystem) CheckOut(id int, stationName string, t int) {
    checkIn := this.checkIns[id]
    delete(this.checkIns, id)
    route := checkIn.station + "-" + stationName
    travelTime := t - checkIn.time
    data := this.travelData[route]
    data.totalTime += travelTime
    data.count++
    this.travelData[route] = data
}

func (this *UndergroundSystem) GetAverageTime(startStation string, endStation string) float64 {
    route := startStation + "-" + endStation
    data := this.travelData[route]
    return float64(data.totalTime) / float64(data.count)
}
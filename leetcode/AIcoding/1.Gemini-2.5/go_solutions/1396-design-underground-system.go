type UndergroundSystem struct {
	checkIns  map[int]struct {
		StationName string
		Time        int
	}
	routeTimes map[string]struct {
		TotalTime int
		Count     int
	}
}

func Constructor() UndergroundSystem {
	return UndergroundSystem{
		checkIns:   make(map[int]struct {
			StationName string
			Time        int
		}),
		routeTimes: make(map[string]struct {
			TotalTime int
			Count     int
		}),
	}
}

func (this *UndergroundSystem) CheckIn(id int, stationName string, t int) {
	this.checkIns[id] = struct {
		StationName string
		Time        int
	}{StationName: stationName, Time: t}
}

func (this *UndergroundSystem) CheckOut(id int, stationName string, t int) {
	checkInInfo := this.checkIns[id]
	delete(this.checkIns, id)

	routeKey := checkInInfo.StationName + "-" + stationName
	tripDuration := t - checkInInfo.Time

	currentStats := this.routeTimes[routeKey]
	currentStats.TotalTime += tripDuration
	currentStats.Count++
	this.routeTimes[routeKey] = currentStats
}

func (this *UndergroundSystem) GetAverageTime(startStation string, endStation string) float64 {
	routeKey := startStation + "-" + endStation
	stats := this.routeTimes[routeKey]
	return float64(stats.TotalTime) / float64(stats.Count)
}
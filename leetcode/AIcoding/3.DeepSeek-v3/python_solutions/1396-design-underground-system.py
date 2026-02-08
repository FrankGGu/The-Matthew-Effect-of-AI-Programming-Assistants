class UndergroundSystem:

    def __init__(self):
        self.check_ins = {}
        self.travel_times = {}

    def checkIn(self, id: int, stationName: str, t: int) -> None:
        self.check_ins[id] = (stationName, t)

    def checkOut(self, id: int, stationName: str, t: int) -> None:
        start_station, start_time = self.check_ins.pop(id)
        route = (start_station, stationName)
        if route not in self.travel_times:
            self.travel_times[route] = []
        self.travel_times[route].append(t - start_time)

    def getAverageTime(self, startStation: str, endStation: str) -> float:
        route = (startStation, endStation)
        times = self.travel_times[route]
        return sum(times) / len(times)
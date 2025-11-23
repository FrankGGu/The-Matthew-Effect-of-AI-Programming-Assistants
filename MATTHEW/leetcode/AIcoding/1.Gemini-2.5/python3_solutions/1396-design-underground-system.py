from collections import defaultdict

class UndergroundSystem:

    def __init__(self):
        self.check_ins = {}
        self.travel_times = defaultdict(lambda: [0, 0])

    def checkIn(self, id: int, stationName: str, t: int) -> None:
        self.check_ins[id] = (stationName, t)

    def checkOut(self, id: int, stationName: str, t: int) -> None:
        start_station, start_time = self.check_ins.pop(id)

        route = (start_station, stationName)
        travel_duration = t - start_time

        self.travel_times[route][0] += travel_duration
        self.travel_times[route][1] += 1

    def getAverageTime(self, startStation: str, endStation: str) -> float:
        route = (startStation, endStation)
        total_duration, count = self.travel_times[route]
        return total_duration / count
class UndergroundSystem:

    def __init__(self):
        self.check_in_map = {}
        self.travel_time = {}

    def checkIn(self, id: int, stationName: str, t: int) -> None:
        self.check_in_map[id] = (stationName, t)

    def checkOut(self, id: int, stationName: str, t: int) -> None:
        start_station, start_time = self.check_in_map[id]
        key = (start_station, stationName)
        if key not in self.travel_time:
            self.travel_time[key] = [0, 0]
        self.travel_time[key][0] += t - start_time
        self.travel_time[key][1] += 1

    def getAverageTime(self, startStation: str, endStation: str) -> float:
        total_time, count = self.travel_time[(startStation, endStation)]
        return total_time / count
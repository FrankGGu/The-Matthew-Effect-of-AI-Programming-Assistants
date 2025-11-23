class UndergroundSystem:

    def __init__(self):
        self.checkin_data = {}
        self.travel_data = {}

    def checkIn(self, id: int, stationName: str, t: int) -> None:
        self.checkin_data[id] = (stationName, t)

    def checkOut(self, id: int, stationName: str, t: int) -> None:
        start_station, start_time = self.checkin_data.pop(id)
        travel_time = t - start_time
        if (start_station, stationName) not in self.travel_data:
            self.travel_data[(start_station, stationName)] = [0, 0]
        self.travel_data[(start_station, stationName)][0] += travel_time
        self.travel_data[(start_station, stationName)][1] += 1

    def getAverageTime(self, startStation: str, endStation: str) -> float:
        total_time, count = self.travel_data[(startStation, endStation)]
        return total_time / count
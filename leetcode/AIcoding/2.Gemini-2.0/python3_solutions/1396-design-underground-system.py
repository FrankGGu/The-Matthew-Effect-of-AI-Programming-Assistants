class UndergroundSystem:

    def __init__(self):
        self.check_in_data = {}
        self.travel_data = {}

    def checkIn(self, id: int, stationName: str, t: int) -> None:
        self.check_in_data[id] = (stationName, t)

    def checkOut(self, id: int, stationName: str, t: int) -> None:
        start_station, start_time = self.check_in_data.pop(id)

        key = (start_station, stationName)
        time_diff = t - start_time

        if key in self.travel_data:
            total_time, count = self.travel_data[key]
            self.travel_data[key] = (total_time + time_diff, count + 1)
        else:
            self.travel_data[key] = (time_diff, 1)

    def getAverageTime(self, startStation: str, endStation: str) -> float:
        key = (startStation, endStation)
        total_time, count = self.travel_data[key]
        return total_time / count
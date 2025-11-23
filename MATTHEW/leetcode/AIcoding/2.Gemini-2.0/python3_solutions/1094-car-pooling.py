class Solution:
    def carPooling(self, trips: list[list[int]], capacity: int) -> bool:
        timeline = [0] * 1001
        for trip in trips:
            num_passengers, start_location, end_location = trip
            timeline[start_location] += num_passengers
            timeline[end_location] -= num_passengers

        current_passengers = 0
        for change in timeline:
            current_passengers += change
            if current_passengers > capacity:
                return False

        return True
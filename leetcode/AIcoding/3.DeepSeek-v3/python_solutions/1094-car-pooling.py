class Solution:
    def carPooling(self, trips: List[List[int]], capacity: int) -> bool:
        max_location = 0
        for trip in trips:
            max_location = max(max_location, trip[2])

        locations = [0] * (max_location + 1)

        for num_passengers, start, end in trips:
            locations[start] += num_passengers
            locations[end] -= num_passengers

        current_passengers = 0
        for i in range(len(locations)):
            current_passengers += locations[i]
            if current_passengers > capacity:
                return False

        return True
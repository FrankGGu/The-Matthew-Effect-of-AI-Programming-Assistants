class Solution:
    def carPooling(self, trips: list[list[int]], capacity: int) -> bool:
        # The maximum location is 1000 according to constraints.
        # We need an array to track passenger changes at each location.
        # Index i represents location i.
        # Size 1001 covers locations from 0 to 1000.
        location_changes = [0] * 1001 

        for num_passengers, start_location, end_location in trips:
            # Passengers get on at start_location
            location_changes[start_location] += num_passengers
            # Passengers get off at end_location.
            # They are not in the car for any trip starting at or after end_location.
            # So, we subtract them at end_location.
            location_changes[end_location] -= num_passengers

        current_passengers = 0
        # Iterate through all possible locations
        for i in range(1001):
            current_passengers += location_changes[i]
            if current_passengers > capacity:
                return False

        return True
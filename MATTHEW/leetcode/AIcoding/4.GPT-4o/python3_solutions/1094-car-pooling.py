class Solution:
    def carPooling(self, trips: List[List[int]], capacity: int) -> bool:
        events = []
        for num_passengers, start, end in trips:
            events.append((start, num_passengers))
            events.append((end, -num_passengers))

        events.sort()
        current_passengers = 0

        for _, change in events:
            current_passengers += change
            if current_passengers > capacity:
                return False

        return True
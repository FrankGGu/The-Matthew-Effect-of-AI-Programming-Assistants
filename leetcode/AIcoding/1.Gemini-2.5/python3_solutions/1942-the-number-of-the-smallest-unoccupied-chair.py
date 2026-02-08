import heapq

class Solution:
    def smallestUnoccupiedChair(self, times: list[list[int]], target_person: int) -> int:
        n = len(times)

        # Create a list of events: (time, event_type, person_id)
        # event_type: 0 for departure, 1 for arrival.
        # This ensures departures are processed before arrivals at the same time,
        # making chairs available for new arrivals.
        events = []
        for i in range(n):
            arrival_time, departure_time = times[i]
            events.append((arrival_time, 1, i)) # Arrival event
            events.append((departure_time, 0, i)) # Departure event

        # Sort events primarily by time, then by event_type (departure before arrival)
        events.sort()

        # Min-heap to store available chair numbers.
        # Initially, all chairs from 0 to n-1 are available.
        available_chairs = list(range(n))
        heapq.heapify(available_chairs)

        # Array to store which chair each person is occupying.
        # person_chair_map[person_id] = chair_number
        person_chair_map = [-1] * n

        for time, event_type, person_id in events:
            if event_type == 1:  # Arrival event
                # A person arrives, they take the smallest numbered unoccupied chair.
                chair_num = heapq.heappop(available_chairs)
                person_chair_map[person_id] = chair_num

                # If this is the target person, we have found their chair.
                if person_id == target_person:
                    return chair_num
            else:  # Departure event
                # A person leaves, their chair becomes unoccupied and is added back to available chairs.
                chair_num_to_free = person_chair_map[person_id]
                heapq.heappush(available_chairs, chair_num_to_free)

        return -1 # Should not be reached if target_person is always present
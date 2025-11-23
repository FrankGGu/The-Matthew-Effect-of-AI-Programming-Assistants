from collections import defaultdict
import heapq

class Solution:
    def mostBooked(self, n: int, meetings: List[List[int]]) -> int:
        time_slots = defaultdict(list)
        for start, end in meetings:
            time_slots[start].append((end, 1))
            time_slots[end].append((start, -1))

        free_rooms = list(range(n))
        heapq.heapify(free_rooms)
        booked_count = [0] * n
        ongoing_meetings = []

        for time in sorted(time_slots.keys()):
            while ongoing_meetings and ongoing_meetings[0][0] <= time:
                _, room = heapq.heappop(ongoing_meetings)
                heapq.heappush(free_rooms, room)

            for end, delta in time_slots[time]:
                if delta == 1:
                    if free_rooms:
                        room = heapq.heappop(free_rooms)
                    else:
                        end_time, room = heapq.heappop(ongoing_meetings)
                        heapq.heappush(ongoing_meetings, (end_time, room))
                        time = end_time
                    booked_count[room] += 1
                    heapq.heappush(ongoing_meetings, (end, room))

        return booked_count.index(max(booked_count))
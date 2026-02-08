import heapq

class Solution:
    def mostBooked(self, n: int, meetings: list[list[int]]) -> int:
        rooms = [0] * n
        available_rooms = list(range(n))
        heapq.heapify(available_rooms)
        occupied_rooms = []
        meetings.sort()

        for start, end in meetings:
            while occupied_rooms and occupied_rooms[0][0] <= start:
                finish_time, room_id = heapq.heappop(occupied_rooms)
                heapq.heappush(available_rooms, room_id)

            if available_rooms:
                room_id = heapq.heappop(available_rooms)
                rooms[room_id] += 1
                heapq.heappush(occupied_rooms, (end, room_id))
            else:
                finish_time, room_id = heapq.heappop(occupied_rooms)
                rooms[room_id] += 1
                new_end = finish_time + (end - start)
                heapq.heappush(occupied_rooms, (new_end, room_id))

        max_meetings = 0
        max_room = 0
        for i in range(n):
            if rooms[i] > max_meetings:
                max_meetings = rooms[i]
                max_room = i
        return max_room
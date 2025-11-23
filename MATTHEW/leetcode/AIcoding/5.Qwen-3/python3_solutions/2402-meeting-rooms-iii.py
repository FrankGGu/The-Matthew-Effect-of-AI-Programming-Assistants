import heapq

class Solution:
    def mostBookedRooms(self, n: int, meetings: List[List[int]]) -> int:
        meetings.sort()
        free = list(range(n))
        used = []
        count = [0] * n

        for start, end in meetings:
            while used and used[0][0] <= start:
                time, room = heapq.heappop(used)
                heapq.heappush(free, room)

            if not free:
                time, room = heapq.heappop(used)
                heapq.heappush(used, (end, room))
            else:
                room = heapq.heappop(free)
                heapq.heappush(used, (end, room))

            count[room] += 1

        return count.index(max(count))
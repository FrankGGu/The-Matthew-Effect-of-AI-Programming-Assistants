import heapq

class Solution:
    def mostBooked(self, n: int, meetings: List[List[int]]) -> int:
        meetings.sort()
        available = list(range(n))
        used = []  # (end_time, room)
        count = [0] * n

        for start, end in meetings:
            while used and used[0][0] <= start:
                _, room = heapq.heappop(used)
                heapq.heappush(available, room)

            if available:
                room = heapq.heappop(available)
                heapq.heappush(used, (end, room))
            else:
                earliest_end, room = heapq.heappop(used)
                new_end = earliest_end + (end - start)
                heapq.heappush(used, (new_end, room))

            count[room] += 1

        return count.index(max(count))
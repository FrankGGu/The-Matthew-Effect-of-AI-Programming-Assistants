import heapq

class Solution:
    def assignTasks(self, servers: List[int], tasks: List[int]) -> List[int]:
        available = []
        for i, weight in enumerate(servers):
            heapq.heappush(available, (weight, i))

        busy = []
        res = []
        time = 0

        for j, duration in enumerate(tasks):
            time = max(time, j)

            if not available:
                time = busy[0][0]

            while busy and busy[0][0] <= time:
                _, weight, i = heapq.heappop(busy)
                heapq.heappush(available, (weight, i))

            weight, i = heapq.heappop(available)
            res.append(i)
            heapq.heappush(busy, (time + duration, weight, i))

        return res
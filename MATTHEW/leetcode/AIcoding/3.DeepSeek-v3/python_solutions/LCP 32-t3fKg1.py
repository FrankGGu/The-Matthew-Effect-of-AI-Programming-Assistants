import heapq

class Solution:
    def batchProcessTasks(self, tasks: List[List[int]]) -> int:
        tasks.sort()
        heap = []
        res = 0
        for start, end, period in tasks:
            while heap and heap[0][0] + res < start:
                t, r = heapq.heappop(heap)
                if t + res < r:
                    res += min(r, start) - (t + res)
            heapq.heappush(heap, (end - period + 1 - res, end + 1))
        while heap:
            t, r = heapq.heappop(heap)
            if t + res < r:
                res += r - (t + res)
        return res
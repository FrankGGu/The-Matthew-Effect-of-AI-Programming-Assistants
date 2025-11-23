import heapq

class Solution:
    def findMaxValueOfEquation(self, points: List[List[int]], k: int) -> int:
        max_heap = []
        res = -float('inf')
        for x, y in points:
            while max_heap and x - max_heap[0][1] > k:
                heapq.heappop(max_heap)
            if max_heap:
                res = max(res, -max_heap[0][0] + y + x)
            heapq.heappush(max_heap, (-(y - x), x))
        return res
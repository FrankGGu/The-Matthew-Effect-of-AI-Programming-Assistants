from typing import List
import heapq

class Solution:
    def minCostToReachEveryPosition(self, nums: List[int]) -> List[int]:
        n = len(nums)
        min_heap = [(0, 0)]
        visited = [False] * n
        result = [float('inf')] * n
        result[0] = 0

        while min_heap:
            cost, i = heapq.heappop(min_heap)
            if visited[i]:
                continue
            visited[i] = True
            for j in range(i + 1, min(i + nums[i] + 1, n)):
                if not visited[j] and cost + 1 < result[j]:
                    result[j] = cost + 1
                    heapq.heappush(min_heap, (result[j], j))

        return result
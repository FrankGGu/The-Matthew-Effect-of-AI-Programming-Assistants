from typing import List
import heapq

class Solution:
    def minCostToDivide(self, nums: List[int]) -> int:
        n = len(nums)
        if n == 0:
            return 0
        heap = []
        for i in range(n - 1):
            heapq.heappush(heap, (nums[i], i))
        cost = 0
        while len(heap) > 1:
            val1, idx1 = heapq.heappop(heap)
            val2, idx2 = heapq.heappop(heap)
            if idx1 > idx2:
                idx1, idx2 = idx2, idx1
            cost += val1 + val2
            new_val = val1 + val2
            heapq.heappush(heap, (new_val, idx1))
        return cost
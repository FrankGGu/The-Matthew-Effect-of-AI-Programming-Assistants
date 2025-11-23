import heapq
from typing import List

class Solution:
    def minOperations(self, nums: List[int]) -> int:
        total = sum(nums)
        target = total / 2
        max_heap = [-num for num in nums]
        heapq.heapify(max_heap)
        operations = 0
        current_sum = total
        while current_sum > target:
            largest = -heapq.heappop(max_heap)
            largest //= 2
            current_sum -= largest
            heapq.heappush(max_heap, -largest)
            operations += 1
        return operations
from typing import List
import heapq

class Solution:
    def maxAndMinSums(self, nums: List[int], k: int) -> List[int]:
        max_heap = [-num for num in nums]
        min_heap = nums[:]
        heapq.heapify(max_heap)
        heapq.heapify(min_heap)

        max_sum = sum(-heapq.heappop(max_heap) for _ in range(k))
        min_sum = sum(heapq.heappop(min_heap) for _ in range(k))

        return [max_sum, min_sum]
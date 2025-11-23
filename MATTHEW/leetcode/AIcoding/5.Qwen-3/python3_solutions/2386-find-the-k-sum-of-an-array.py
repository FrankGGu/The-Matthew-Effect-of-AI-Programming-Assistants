from typing import List
import heapq

class Solution:
    def kSum(self, nums: List[int], k: int) -> int:
        max_heap = []
        total_sum = sum(nums)
        nums = sorted(nums)

        heapq.heappush(max_heap, (-total_sum, 0))

        for _ in range(k - 1):
            current_sum, index = heapq.heappop(max_heap)
            current_sum = -current_sum
            if index < len(nums):
                heapq.heappush(max_heap, (-(current_sum - nums[index]), index + 1))
                heapq.heappush(max_heap, (-(current_sum - nums[index] + nums[index - 1]), index + 1))

        return -max_heap[0][0]
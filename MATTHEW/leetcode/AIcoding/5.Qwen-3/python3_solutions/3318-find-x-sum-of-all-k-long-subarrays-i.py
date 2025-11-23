from typing import List
from collections import deque

class Solution:
    def kSum(self, nums: List[int], k: int) -> int:
        max_heap = []
        n = len(nums)
        for i in range(n):
            current_sum = 0
            for j in range(i, n):
                current_sum += nums[j]
                if len(max_heap) < k:
                    heapq.heappush(max_heap, -current_sum)
                else:
                    if -current_sum > max_heap[0]:
                        heapq.heappop(max_heap)
                        heapq.heappush(max_heap, -current_sum)
        return -max_heap[0]
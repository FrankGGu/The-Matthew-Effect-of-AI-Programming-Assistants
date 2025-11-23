from typing import List
import heapq

class Solution:
    def available(self, nums: List[int], k: int) -> bool:
        heap = [-num for num in nums]
        heapq.heapify(heap)
        while k > 0:
            max_val = -heapq.heappop(heap)
            if max_val == 0:
                break
            max_val -= 1
            k -= 1
            heapq.heappush(heap, -max_val)
        return all(-x == 0 for x in heap)
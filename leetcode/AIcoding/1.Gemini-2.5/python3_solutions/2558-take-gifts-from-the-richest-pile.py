import heapq
import math

class Solution:
    def pickGifts(self, gifts: list[int], k: int) -> int:
        max_heap = []
        for gift in gifts:
            heapq.heappush(max_heap, -gift)

        for _ in range(k):
            largest_gift = -heapq.heappop(max_heap)
            new_gift = math.isqrt(largest_gift)
            heapq.heappush(max_heap, -new_gift)

        total_gifts = 0
        while max_heap:
            total_gifts += -heapq.heappop(max_heap)

        return total_gifts
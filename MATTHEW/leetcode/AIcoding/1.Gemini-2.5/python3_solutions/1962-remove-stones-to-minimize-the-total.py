import heapq

class Solution:
    def minStoneSum(self, piles: list[int], k: int) -> int:
        max_heap = []
        for pile in piles:
            heapq.heappush(max_heap, -pile)

        for _ in range(k):
            largest_pile = -heapq.heappop(max_heap)
            stones_to_remove = largest_pile // 2
            new_pile_size = largest_pile - stones_to_remove
            heapq.heappush(max_heap, -new_pile_size)

        total_stones = 0
        while max_heap:
            total_stones += -heapq.heappop(max_heap)

        return total_stones
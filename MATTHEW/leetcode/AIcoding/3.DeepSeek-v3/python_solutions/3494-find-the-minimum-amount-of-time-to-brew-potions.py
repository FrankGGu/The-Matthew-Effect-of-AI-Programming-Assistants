import heapq

class Solution:
    def minimumTime(self, potions: List[int], target: int) -> int:
        heap = []
        for potion in potions:
            heapq.heappush(heap, potion)

        operations = 0
        while True:
            smallest = heapq.heappop(heap)
            if smallest >= target:
                return operations
            new_potion = smallest + heapq.heappop(heap) * 2
            heapq.heappush(heap, new_potion)
            operations += 1
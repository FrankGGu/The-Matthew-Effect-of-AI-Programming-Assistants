import heapq

class Solution:
    def lastStoneWeight(self, stones: list[int]) -> int:
        heap = []
        for stone in stones:
            heapq.heappush(heap, -stone)

        while len(heap) > 1:
            y = -heapq.heappop(heap)
            x = -heapq.heappop(heap)

            if y > x:
                heapq.heappush(heap, -(y - x))

        if not heap:
            return 0
        else:
            return -heapq.heappop(heap)
import heapq

class Solution:
    def stockManagement(self, stock: list[int], k: int) -> int:
        min_heap = []
        for num in stock:
            if len(min_heap) < k:
                heapq.heappush(min_heap, num)
            elif num > min_heap[0]:
                heapq.heappop(min_heap)
                heapq.heappush(min_heap, num)

        return sum(min_heap)
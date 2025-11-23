import heapq

class Solution:
    def pickGifts(self, gifts: List[int], k: int) -> int:
        max_heap = []
        for num in gifts:
            heapq.heappush(max_heap, -num)

        for _ in range(k):
            if not max_heap:
                break
            current = -heapq.heappop(max_heap)
            remaining = int(current ** 0.5)
            heapq.heappush(max_heap, -remaining)

        return sum(-num for num in max_heap)
import heapq

class Solution:
    def minStoneSum(self, piles: list[int], k: int) -> int:
        heap = [-x for x in piles]
        heapq.heapify(heap)

        for _ in range(k):
            max_pile = -heapq.heappop(heap)
            remove = max_pile // 2
            heapq.heappush(heap, -(max_pile - remove))

        return -sum(heap)
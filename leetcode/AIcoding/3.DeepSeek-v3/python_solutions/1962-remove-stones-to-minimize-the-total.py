import heapq

class Solution:
    def minStoneSum(self, piles: List[int], k: int) -> int:
        max_heap = [-x for x in piles]
        heapq.heapify(max_heap)

        for _ in range(k):
            if not max_heap:
                break
            current = -heapq.heappop(max_heap)
            remove = current // 2
            heapq.heappush(max_heap, -(current - remove))

        return sum(-x for x in max_heap)
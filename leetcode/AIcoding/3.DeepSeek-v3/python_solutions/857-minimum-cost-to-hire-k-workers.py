import heapq

class Solution:
    def mincostToHireWorkers(self, quality: List[int], wage: List[int], k: int) -> float:
        workers = sorted((w / q, q) for w, q in zip(wage, quality))
        max_heap = []
        sum_q = 0
        res = float('inf')

        for ratio, q in workers:
            heapq.heappush(max_heap, -q)
            sum_q += q

            if len(max_heap) > k:
                sum_q += heapq.heappop(max_heap)

            if len(max_heap) == k:
                res = min(res, ratio * sum_q)

        return res
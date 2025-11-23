import heapq

class Solution:
    def mincostToHireWorkers(self, quality: List[int], wage: List[int], K: int) -> float:
        workers = sorted([(w / q, q) for w, q in zip(wage, quality)])
        heap = []
        quality_sum = 0
        res = float('inf')

        for ratio, q in workers:
            heapq.heappush(heap, -q)
            quality_sum += q

            if len(heap) > K:
                quality_sum += heapq.heappop(heap)

            if len(heap) == K:
                res = min(res, ratio * quality_sum)

        return res
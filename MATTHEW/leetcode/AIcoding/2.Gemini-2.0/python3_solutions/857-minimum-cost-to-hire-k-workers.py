import heapq

class Solution:
    def mincostToHireWorkers(self, quality: list[int], wage: list[int], k: int) -> float:
        workers = sorted([(wage[i] / quality[i], quality[i]) for i in range(len(quality))])

        heap = []
        quality_sum = 0
        min_cost = float('inf')

        for ratio, q in workers:
            heapq.heappush(heap, -q)
            quality_sum += q

            if len(heap) > k:
                quality_sum += heapq.heappop(heap)

            if len(heap) == k:
                min_cost = min(min_cost, ratio * quality_sum)

        return min_cost
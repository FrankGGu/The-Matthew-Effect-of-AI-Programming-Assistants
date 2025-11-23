class Solution:
    def minCostToHireKWorkers(self, quality: List[int], wage: List[int], k: int) -> float:
        workers = sorted(zip(quality, wage), key=lambda x: x[1] / x[0])
        max_heap = []
        total_quality = 0
        min_cost = float('inf')

        for q, w in workers:
            ratio = w / q
            if len(max_heap) >= k:
                total_quality -= -heapq.heappop(max_heap)
            heapq.heappush(max_heap, -q)
            total_quality += q
            if len(max_heap) == k:
                min_cost = min(min_cost, total_quality * ratio)

        return min_cost
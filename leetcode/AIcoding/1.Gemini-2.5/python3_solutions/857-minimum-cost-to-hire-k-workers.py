import heapq

class Solution:
    def minCostToHireWorkers(self, quality: list[int], wage: list[int], k: int) -> float:
        workers = []
        for i in range(len(quality)):
            workers.append((wage[i] / quality[i], quality[i]))

        workers.sort()

        min_cost = float('inf')
        current_quality_sum = 0
        max_heap = [] 

        for ratio, q in workers:
            heapq.heappush(max_heap, -q) 
            current_quality_sum += q

            if len(max_heap) > k:
                largest_quality_in_heap = -heapq.heappop(max_heap)
                current_quality_sum -= largest_quality_in_heap

            if len(max_heap) == k:
                min_cost = min(min_cost, ratio * current_quality_sum)

        return min_cost
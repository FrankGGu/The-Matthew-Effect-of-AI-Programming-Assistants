import heapq

class Solution:
    def totalCost(self, costs: List[int], k: int, candidates: int) -> int:
        n = len(costs)
        left, right = 0, n - 1
        min_heap = []
        total_cost = 0

        for _ in range(k):
            while len(min_heap) < candidates and left <= right:
                heapq.heappush(min_heap, costs[left])
                left += 1

            if len(min_heap) < candidates and left > right:
                break

            total_cost += heapq.heappop(min_heap)

            if left <= right:
                heapq.heappush(min_heap, costs[right])
                right -= 1

        return total_cost
import heapq

class Solution:
    def totalCost(self, costs: List[int], k: int, candidates: int) -> int:
        left_heap = []
        right_heap = []
        n = len(costs)
        left_ptr = 0
        right_ptr = n - 1

        for _ in range(candidates):
            if left_ptr <= right_ptr:
                heapq.heappush(left_heap, costs[left_ptr])
                left_ptr += 1
            if left_ptr <= right_ptr:
                heapq.heappush(right_heap, costs[right_ptr])
                right_ptr -= 1

        total_cost = 0
        for _ in range(k):
            if not right_heap or (left_heap and left_heap[0] <= right_heap[0]):
                total_cost += heapq.heappop(left_heap)
                if left_ptr <= right_ptr:
                    heapq.heappush(left_heap, costs[left_ptr])
                    left_ptr += 1
            else:
                total_cost += heapq.heappop(right_heap)
                if left_ptr <= right_ptr:
                    heapq.heappush(right_heap, costs[right_ptr])
                    right_ptr -= 1

        return total_cost
import heapq

class Solution:
    def totalCost(self, costs: list[int], k: int, candidates: int) -> int:
        n = len(costs)
        total_cost = 0

        left_heap = []
        right_heap = []

        l = 0
        r = n - 1

        for _ in range(candidates):
            if l <= r:
                heapq.heappush(left_heap, costs[l])
                l += 1
            else:
                break

        for _ in range(candidates):
            if l <= r:
                heapq.heappush(right_heap, costs[r])
                r -= 1
            else:
                break

        for _ in range(k):
            if not left_heap:
                cost = heapq.heappop(right_heap)
                total_cost += cost
                if l <= r:
                    heapq.heappush(right_heap, costs[r])
                    r -= 1
            elif not right_heap:
                cost = heapq.heappop(left_heap)
                total_cost += cost
                if l <= r:
                    heapq.heappush(left_heap, costs[l])
                    l += 1
            else:
                left_min = left_heap[0]
                right_min = right_heap[0]

                if left_min <= right_min:
                    cost = heapq.heappop(left_heap)
                    total_cost += cost
                    if l <= r:
                        heapq.heappush(left_heap, costs[l])
                        l += 1
                else:
                    cost = heapq.heappop(right_heap)
                    total_cost += cost
                    if l <= r:
                        heapq.heappush(right_heap, costs[r])
                        r -= 1

        return total_cost
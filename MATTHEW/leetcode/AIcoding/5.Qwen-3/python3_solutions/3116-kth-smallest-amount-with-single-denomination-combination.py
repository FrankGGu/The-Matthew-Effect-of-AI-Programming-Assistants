import heapq

class Solution:
    def kthSmallestAmount(self, coins: List[int], k: int) -> int:
        visited = set()
        heap = []
        heapq.heappush(heap, (0, 0))
        visited.add(0)

        while heap:
            amount, index = heapq.heappop(heap)
            k -= 1
            if k == 0:
                return amount
            if index + 1 < len(coins):
                next_amount = amount + coins[index + 1]
                if next_amount not in visited:
                    visited.add(next_amount)
                    heapq.heappush(heap, (next_amount, index + 1))
                next_amount = amount + coins[index]
                if next_amount not in visited:
                    visited.add(next_amount)
                    heapq.heappush(heap, (next_amount, index))
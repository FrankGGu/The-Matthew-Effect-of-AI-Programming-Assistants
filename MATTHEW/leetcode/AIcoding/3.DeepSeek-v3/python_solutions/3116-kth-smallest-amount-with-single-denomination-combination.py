import heapq

class Solution:
    def findKthSmallest(self, coins: List[int], k: int) -> int:
        heap = []
        visited = set()

        for coin in coins:
            heapq.heappush(heap, coin)
            visited.add(coin)

        current = 0
        for _ in range(k):
            current = heapq.heappop(heap)
            for coin in coins:
                next_val = current + coin
                if next_val not in visited:
                    visited.add(next_val)
                    heapq.heappush(heap, next_val)

        return current
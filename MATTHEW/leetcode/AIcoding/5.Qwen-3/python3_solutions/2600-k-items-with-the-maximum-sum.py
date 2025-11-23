class Solution:
    def kItemsWithMaximumSum(self, numCoins: int, numCards: int, k: int, coins: List[int]) -> int:
        import heapq
        max_heap = []
        for i in range(numCards):
            if coins[i] == 1:
                heapq.heappush(max_heap, -coins[i])
            else:
                heapq.heappush(max_heap, -coins[i])
        total = 0
        for _ in range(k):
            total += -heapq.heappop(max_heap)
        return total
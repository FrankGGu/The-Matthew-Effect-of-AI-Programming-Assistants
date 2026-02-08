import math

class Solution:
    def findCheapestPrice(self, n: int, flights: list[list[int]], src: int, dst: int, k: int) -> int:
        prices = [math.inf] * n
        prices[src] = 0

        for _ in range(k + 1):
            temp_prices = list(prices)
            for u, v, w in flights:
                if prices[u] != math.inf:
                    temp_prices[v] = min(temp_prices[v], prices[u] + w)
            prices = temp_prices

        return prices[dst] if prices[dst] != math.inf else -1
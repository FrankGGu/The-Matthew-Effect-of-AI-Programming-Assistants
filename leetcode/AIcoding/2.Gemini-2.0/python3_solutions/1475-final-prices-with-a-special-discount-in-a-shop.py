class Solution:
    def finalPrices(self, prices: List[int]) -> List[int]:
        n = len(prices)
        result = []
        for i in range(n):
            discount = 0
            for j in range(i + 1, n):
                if prices[j] <= prices[i]:
                    discount = prices[j]
                    break
            result.append(prices[i] - discount)
        return result
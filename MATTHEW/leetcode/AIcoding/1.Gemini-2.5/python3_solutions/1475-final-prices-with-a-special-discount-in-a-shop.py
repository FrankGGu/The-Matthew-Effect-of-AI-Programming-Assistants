class Solution:
    def finalPrices(self, prices: list[int]) -> list[int]:
        stack = []
        n = len(prices)

        for i in range(n):
            while stack and prices[stack[-1]] >= prices[i]:
                j = stack.pop()
                prices[j] -= prices[i]
            stack.append(i)

        return prices
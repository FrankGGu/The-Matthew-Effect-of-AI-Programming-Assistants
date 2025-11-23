class Solution:
    def finalPrices(self, prices: List[int]) -> List[int]:
        n = len(prices)
        stack = []
        result = prices[:]

        for i in range(n):
            while stack and prices[stack[-1]] >= prices[i]:
                j = stack.pop()
                result[j] -= prices[i]
            stack.append(i)

        return result
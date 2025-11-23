class Solution:
    def getDescentPeriods(self, prices: List[int]) -> int:
        n = len(prices)
        if n == 0:
            return 0
        total = 1
        current = 1
        for i in range(1, n):
            if prices[i] == prices[i-1] - 1:
                current += 1
            else:
                current = 1
            total += current
        return total
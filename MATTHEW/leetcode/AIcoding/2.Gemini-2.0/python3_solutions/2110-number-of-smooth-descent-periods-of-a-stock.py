class Solution:
    def getDescentPeriods(self, prices: list[int]) -> int:
        n = len(prices)
        ans = 0
        l = 0
        for r in range(n):
            if r > 0 and prices[r] != prices[r-1] - 1:
                l = r
            ans += r - l + 1
        return ans
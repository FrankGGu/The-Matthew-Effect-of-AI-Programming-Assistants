from typing import List

class Solution:
    def maxTaxiEarnings(self, n: int, rides: List[List[int]]) -> int:
        rides.sort(key=lambda x: x[1])
        dp = [0] * (n + 1)
        for start, end, tip in rides:
            i = end
            j = start
            while j > 0:
                j -= 1
                if j <= i:
                    dp[i] = max(dp[i], dp[j] + end - start + tip)
        return dp[n]
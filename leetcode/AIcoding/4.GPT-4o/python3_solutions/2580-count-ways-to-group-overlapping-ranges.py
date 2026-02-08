class Solution:
    def countWays(self, ranges: List[List[int]]) -> int:
        MOD = 10**9 + 7

        ranges.sort(key=lambda x: x[0])
        dp = [0] * (len(ranges) + 1)
        dp[0] = 1

        j = 0
        for i in range(1, len(ranges) + 1):
            while j < i and ranges[j][1] < ranges[i - 1][0]:
                j += 1
            dp[i] = (dp[i - 1] + dp[j]) % MOD

        return dp[len(ranges)]
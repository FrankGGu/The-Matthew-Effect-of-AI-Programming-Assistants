class Solution:
    def minOperations(self, s1: str, s2: str, x: int) -> int:
        diff = []
        for i in range(len(s1)):
            if s1[i] != s2[i]:
                diff.append(i)

        n = len(diff)

        if n % 2 != 0:
            return -1

        dp = [float('inf')] * (n + 1)
        dp[0] = 0

        for i in range(2, n + 1, 2):
            dp[i] = min(dp[i - 2] + min(x, diff[i - 1] - diff[i - 2]), dp[i - 1])
            if i > 2:
                dp[i] = min(dp[i], dp[i - 3] + min(x + diff[i-1] - diff[i-3], diff[i-2] - diff[i-3] + diff[i-1] - diff[i-2]))

        return dp[n]
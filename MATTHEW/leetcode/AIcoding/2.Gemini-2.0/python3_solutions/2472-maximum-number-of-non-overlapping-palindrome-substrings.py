class Solution:
    def maxNonOverlapping(self, s: str, k: int) -> int:
        n = len(s)
        dp = [0] * (n + 1)
        last = -1

        for i in range(1, n + 1):
            dp[i] = dp[i - 1]
            for j in range(i - 1, -1, -1):
                sub = s[j:i]
                if len(sub) >= k and sub == sub[::-1]:
                    if j > last:
                        dp[i] = max(dp[i], dp[j] + 1)
                        last = i - 1
                        break

        return dp[n]
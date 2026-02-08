class Solution:
    def maximumDeletions(self, s: str) -> int:
        last_seen = {}
        dp = [0] * (len(s) + 1)

        for i in range(1, len(s) + 1):
            dp[i] = dp[i - 1] + 1
            if s[i - 1] in last_seen:
                dp[i] = max(dp[i], dp[last_seen[s[i - 1]]] + 1)
            last_seen[s[i - 1]] = i - 1

        return dp[len(s)]
class Solution:
    def minChanges(self, s: str, k: int) -> int:
        n = len(s)
        if k == 1:
            return sum(s[i] != s[n - i - 1] for i in range(n // 2))

        dp = [[float('inf')] * (k + 1) for _ in range(n + 1)]
        dp[0][0] = 0

        for i in range(1, n + 1):
            for j in range(1, min(k, i) + 1):
                count = [0] * 26
                for l in range(i - 1, -1, -1):
                    count[ord(s[l]) - ord('a')] += 1
                    changes = (i - l) - max(count)
                    dp[i][j] = min(dp[i][j], dp[l][j - 1] + changes)

        return dp[n][k]
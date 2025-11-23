class Solution:
    def numWays(self, words: List[str], target: str) -> int:
        from collections import defaultdict

        MOD = 10**9 + 7
        n = len(target)
        m = len(words[0])
        count = [defaultdict(int) for _ in range(m)]

        for word in words:
            for i, c in enumerate(word):
                count[i][c] += 1

        dp = [[0] * (n + 1) for _ in range(m + 1)]
        for i in range(m + 1):
            dp[i][0] = 1

        for i in range(1, m + 1):
            for j in range(1, n + 1):
                dp[i][j] = (dp[i - 1][j] + dp[i - 1][j - 1] * count[i - 1][target[j - 1]]) % MOD

        return dp[m][n]
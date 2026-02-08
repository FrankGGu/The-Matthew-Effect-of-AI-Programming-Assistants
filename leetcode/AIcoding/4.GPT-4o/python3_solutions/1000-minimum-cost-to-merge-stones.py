class Solution:
    def mergeStones(self, stones: List[int], K: int) -> int:
        n = len(stones)
        if (n - 1) % (K - 1) != 0:
            return -1

        dp = [[[float('inf')] * (K + 1) for _ in range(n)] for _ in range(n)]
        prefix = [0] * (n + 1)

        for i in range(n):
            prefix[i + 1] = prefix[i] + stones[i]
            dp[i][i][1] = 0

        for length in range(2, n + 1):
            for i in range(n - length + 1):
                j = i + length - 1
                for m in range(1, K + 1):
                    for mid in range(i, j):
                        dp[i][j][m] = min(dp[i][j][m], dp[i][mid][m] + dp[mid + 1][j][m])
                    if m > 1:
                        dp[i][j][1] = min(dp[i][j][1], dp[i][j][m] + prefix[j + 1] - prefix[i])

        return dp[0][n - 1][1]
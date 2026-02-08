class Solution:
    def minimumChanges(self, s: str, k: int) -> int:
        n = len(s)
        cost = [[0] * n for _ in range(n)]

        for i in range(n):
            for j in range(i + 1, n):
                length = j - i + 1
                min_cost = float('inf')
                for d in range(1, length):
                    if length % d != 0:
                        continue
                    current_cost = 0
                    for m in range(d):
                        left = i + m
                        right = j - (d - 1 - m)
                        while left < right:
                            if s[left] != s[right]:
                                current_cost += 1
                            left += d
                            right -= d
                    min_cost = min(min_cost, current_cost)
                cost[i][j] = min_cost if min_cost != float('inf') else 0

        dp = [[float('inf')] * (k + 1) for _ in range(n + 1)]
        dp[0][0] = 0

        for i in range(1, n + 1):
            for j in range(1, k + 1):
                for l in range(i):
                    if dp[l][j - 1] != float('inf'):
                        dp[i][j] = min(dp[i][j], dp[l][j - 1] + cost[l][i - 1])

        return dp[n][k]
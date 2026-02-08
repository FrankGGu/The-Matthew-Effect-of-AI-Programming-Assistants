class Solution:
    def maxValue(self, n: int, passes: int, value: List[int]) -> int:
        dp = [[0] * (passes + 1) for _ in range(n)]

        for i in range(n):
            dp[i][0] = value[i]

        for p in range(1, passes + 1):
            for i in range(n):
                dp[i][p] = value[i]
                for j in range(n):
                    if i != j:
                        dp[i][p] = max(dp[i][p], dp[j][p - 1] + value[i])

        return max(dp[i][passes] for i in range(n))
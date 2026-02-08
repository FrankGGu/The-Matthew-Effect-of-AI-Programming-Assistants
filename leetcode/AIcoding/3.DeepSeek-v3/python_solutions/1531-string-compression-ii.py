class Solution:
    def getLengthOfOptimalCompression(self, s: str, k: int) -> int:
        n = len(s)
        dp = [[float('inf')] * (k + 1) for _ in range(n + 1)]
        dp[0][0] = 0

        for i in range(1, n + 1):
            for j in range(k + 1):
                if j > 0:
                    dp[i][j] = dp[i - 1][j - 1]

                same = 0
                diff = 0
                for m in range(i, 0, -1):
                    if s[m - 1] == s[i - 1]:
                        same += 1
                    else:
                        diff += 1
                    if diff > j:
                        break
                    length = 0
                    if same == 1:
                        length = 1
                    elif same < 10:
                        length = 2
                    elif same < 100:
                        length = 3
                    else:
                        length = 4
                    dp[i][j] = min(dp[i][j], dp[m - 1][j - diff] + length)

        return dp[n][k]
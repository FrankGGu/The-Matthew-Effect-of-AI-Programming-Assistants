class Solution:
    def getLengthOfOptimalCompression(self, s: str, k: int) -> int:
        n = len(s)
        dp = [[float('inf')] * (k + 1) for _ in range(n + 1)]
        dp[0][0] = 0

        for i in range(1, n + 1):
            for j in range(k + 1):
                if j > 0:
                    dp[i][j] = dp[i - 1][j - 1]

                count = 0
                diff = 0
                for l in range(i, 0, -1):
                    if s[l - 1] == s[i - 1]:
                        count += 1
                    else:
                        diff += 1

                    if j + diff <= k:
                        len_str = 1 if count == 1 else (2 if count < 10 else (3 if count < 100 else 4))
                        dp[i][j + diff] = min(dp[i][j + diff], dp[l - 1][j] + len_str)

        return min(dp[n])
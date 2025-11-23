class Solution:
    def countArrays(self, n: int, m: int, k: int) -> int:
        MOD = 10**9 + 7

        if k < 0 or k >= n:
            return 0

        dp = [[[0] * (k + 2) for _ in range(m + 2)] for __ in range(n + 2)]

        for j in range(1, m + 1):
            dp[1][j][0] = 1

        for i in range(2, n + 1):
            for prev in range(1, m + 1):
                for cnt in range(0, k + 1):
                    if dp[i - 1][prev][cnt] == 0:
                        continue
                    for curr in range(1, m + 1):
                        new_cnt = cnt + (1 if curr == prev else 0)
                        if new_cnt > k:
                            continue
                        dp[i][curr][new_cnt] = (dp[i][curr][new_cnt] + dp[i - 1][prev][cnt]) % MOD

        total = 0
        for j in range(1, m + 1):
            total = (total + dp[n][j][k]) % MOD

        return total
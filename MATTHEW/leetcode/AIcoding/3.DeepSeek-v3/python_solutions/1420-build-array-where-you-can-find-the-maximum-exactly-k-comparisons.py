class Solution:
    def numOfArrays(self, n: int, m: int, k: int) -> int:
        MOD = 10**9 + 7

        if k == 0 or k > m:
            return 0

        dp = [[[0] * (k + 1) for _ in range(m + 1)] for __ in range(n + 1)]

        for num in range(1, m + 1):
            dp[1][num][1] = 1

        for i in range(2, n + 1):
            for max_num in range(1, m + 1):
                for cost in range(1, k + 1):
                    # Case 1: new element is not the new maximum
                    dp[i][max_num][cost] = dp[i - 1][max_num][cost] * max_num % MOD
                    # Case 2: new element is the new maximum
                    for prev_max in range(1, max_num):
                        dp[i][max_num][cost] = (dp[i][max_num][cost] + dp[i - 1][prev_max][cost - 1]) % MOD

        total = 0
        for num in range(1, m + 1):
            total = (total + dp[n][num][k]) % MOD

        return total
class Solution:
    def numberOfStableArrays(self, zeros: int, ones: int, limit: int) -> int:
        MOD = 10**9 + 7

        # dp[i][j][0] = number of stable arrays with i zeros and j ones, ending with '0'
        # dp[i][j][1] = number of stable arrays with i zeros and j ones, ending with '1'
        dp = [[[0] * 2 for _ in range(ones + 1)] for _ in range(zeros + 1)]

        # Base cases: Arrays consisting of only zeros or only ones
        # An array of 'k' zeros is stable if k <= limit.
        # An array of 'k' ones is stable if k <= limit.
        for k in range(1, limit + 1):
            if k <= zeros:
                dp[k][0][0] = 1
            if k <= ones:
                dp[0][k][1] = 1

        # Fill the DP table
        # i represents current count of zeros, j represents current count of ones
        for i in range(zeros + 1):
            for j in range(ones + 1):
                # Skip the (0,0) case as it's not a stable array
                if i == 0 and j == 0:
                    continue

                # Calculate dp[i][j][0] (ending with '0')
                # dp[i][j][0] is the sum of dp[i-k][j][1] for k from 1 to limit.
                # This sum can be computed using a sliding window sum (prefix sum optimization):
                # dp[i][j][0] = (dp[i-1][j][0] + dp[i-1][j][1]) - dp[i-limit-1][j][1]
                # The term dp[i-1][j][0] represents the sum of dp[x][j][1] for x in [i-2, ..., i-limit-1].
                # We add dp[i-1][j][1] to extend the window to [i-1, ..., i-limit].
                # We subtract dp[i-limit-1][j][1] to remove the oldest term from the window.
                if i > 0:
                    dp[i][j][0] = (dp[i-1][j][0] + dp[i-1][j][1]) % MOD
                    if i - limit - 1 >= 0:
                        dp[i][j][0] = (dp[i][j][0] - dp[i-limit-1][j][1] + MOD) % MOD

                # Calculate dp[i][j][1] (ending with '1')
                # dp[i][j][1] is the sum of dp[i][j-k][0] for k from 1 to limit.
                # Similar sliding window sum:
                # dp[i][j][1] = (dp[i][j-1][1] + dp[i][j-1][0]) - dp[i][j-limit-1][0]
                if j > 0:
                    dp[i][j][1] = (dp[i][j-1][1] + dp[i][j-1][0]) % MOD
                    if j - limit - 1 >= 0:
                        dp[i][j][1] = (dp[i][j][1] - dp[i][j-limit-1][0] + MOD) % MOD

        # The total number of stable arrays is the sum of arrays ending with '0' and arrays ending with '1'
        return (dp[zeros][ones][0] + dp[zeros][ones][1]) % MOD
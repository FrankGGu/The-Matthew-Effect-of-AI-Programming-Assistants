class Solution:
    def stableBinaryArray(self, zero: int, one: int, limit: int) -> int:
        MOD = 10**9 + 7

        # dp[i][j][0]: count of stable arrays with i zeros, j ones, ending with 0
        # dp[i][j][1]: count of stable arrays with i zeros, j ones, ending with 1
        dp = [[[0] * 2 for _ in range(one + 1)] for _ in range(zero + 1)]

        # sum_dp_0[i][j]: sum of dp[i][k][0] for k from 0 to j (prefix sum along j for fixed i, ending with 0)
        # sum_dp_1[i][j]: sum of dp[k][j][1] for k from 0 to i (prefix sum along i for fixed j, ending with 1)
        sum_dp_0 = [[0] * (one + 1) for _ in range(zero + 1)]
        sum_dp_1 = [[0] * (one + 1) for _ in range(zero + 1)]

        # Step 1: Initialize base cases for dp
        # These are arrays consisting only of 0s or only of 1s
        # e.g., "0", "00", ..., "0...0" (up to 'limit' zeros)
        # e.g., "1", "11", ..., "1...1" (up to 'limit' ones)
        for k in range(1, limit + 1):
            if k <= zero:
                dp[k][0][0] = 1
            if k <= one:
                dp[0][k][1] = 1

        # Step 2: Initialize prefix sums using the base cases
        # This populates sum_dp_0[i][j] and sum_dp_1[i][j] for all i,j where i=0 or j=0.
        # It also populates sum_dp_0[i][j] and sum_dp_1[i][j] for all i,j where dp[i][j][0/1] was non-zero.
        for i in range(zero + 1):
            for j in range(one + 1):
                # Update sum_dp_0[i][j]
                sum_dp_0[i][j] = dp[i][j][0]
                if j > 0:
                    sum_dp_0[i][j] = (sum_dp_0[i][j] + sum_dp_0[i][j-1]) % MOD

        for j in range(one + 1):
            for i in range(zero + 1):
                # Update sum_dp_1[i][j]
                sum_dp_1[i][j] = dp[i][j][1]
                if i > 0:
                    sum_dp_1[i][j] = (sum_dp_1[i][j] + sum_dp_1[i-1][j]) % MOD

        # Step 3: Fill the rest of the DP table and update prefix sums
        # Iterate i from 1 to zero, j from 1 to one (as i=0 or j=0 are base cases/initialized)
        for i in range(1, zero + 1):
            for j in range(1, one + 1):
                # Calculate dp[i][j][0] (ending with '0')
                # An array ending with '0' can be formed by appending '0' to:
                # 1. An array ending with '1' (e.g., "...10")
                # 2. An array ending with '0' (e.g., "...00")
                # The constraint is that the block of '0's must not exceed 'limit'.
                # This is equivalent to summing dp[i-k][j][1] for k from 1 to min(i, limit).
                # Using prefix sums, this sum is (sum_dp_1[i-1][j] - sum_dp_1[i-limit-1][j]).
                val_0 = sum_dp_1[i-1][j]
                if i - limit - 1 >= 0:
                    val_0 = (val_0 - sum_dp_1[i-limit-1][j] + MOD) % MOD
                dp[i][j][0] = val_0

                # Calculate dp[i][j][1] (ending with '1')
                # Similar logic for arrays ending with '1'.
                # This is equivalent to summing dp[i][j-k][0] for k from 1 to min(j, limit).
                # Using prefix sums, this sum is (sum_dp_0[i][j-1] - sum_dp_0[i][j-limit-1]).
                val_1 = sum_dp_0[i][j-1]
                if j - limit - 1 >= 0:
                    val_1 = (val_1 - sum_dp_0[i][j-limit-1] + MOD) % MOD
                dp[i][j][1] = val_1

                # Update prefix sums for current (i,j)
                sum_dp_0[i][j] = (sum_dp_0[i][j-1] + dp[i][j][0]) % MOD
                sum_dp_1[i][j] = (sum_dp_1[i-1][j] + dp[i][j][1]) % MOD

        # The final result is the sum of stable arrays ending with '0' and stable arrays ending with '1'
        # using all 'zero' zeros and 'one' ones.
        result = (dp[zero][one][0] + dp[zero][one][1]) % MOD
        return result
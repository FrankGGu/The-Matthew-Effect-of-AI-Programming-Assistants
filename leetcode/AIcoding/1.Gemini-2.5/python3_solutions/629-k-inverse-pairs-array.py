class Solution:
    def kInversePairs(self, n: int, k: int) -> int:
        MOD = 10**9 + 7

        # dp[i][j] will store the number of arrays with i elements and j inverse pairs
        dp = [[0] * (k + 1) for _ in range(n + 1)]

        # Base case: For 0 elements, there is 1 way to have 0 inverse pairs (an empty array)
        dp[0][0] = 1

        # Iterate through the number of elements from 1 to n
        for i in range(1, n + 1):
            # Iterate through the number of inverse pairs from 0 to k
            for j in range(k + 1):
                # The recurrence relation is dp[i][j] = dp[i][j-1] + dp[i-1][j] - dp[i-1][j-i]
                # This is derived from the sum: dp[i][j] = sum(dp[i-1][j-x]) for x from 0 to min(j, i-1)
                # where x represents the number of new inverse pairs created by inserting 'i'

                # Start with dp[i][j-1] (if j > 0)
                val = 0
                if j > 0:
                    val = dp[i][j-1]

                # Add dp[i-1][j]
                val = (val + dp[i-1][j]) % MOD

                # Subtract dp[i-1][j-i] if j >= i
                # This term accounts for the sliding window sum optimization
                if j >= i:
                    val = (val - dp[i-1][j-i] + MOD) % MOD

                dp[i][j] = val

        return dp[n][k]
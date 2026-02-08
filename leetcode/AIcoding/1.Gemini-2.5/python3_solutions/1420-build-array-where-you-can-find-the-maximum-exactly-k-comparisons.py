class Solution:
    def numOfArrays(self, n: int, m: int, k: int) -> int:
        MOD = 10**9 + 7

        # dp[i][j][c] represents the number of ways to build an array of length i,
        # where the maximum element is j, and exactly c comparisons have been made.
        # i: current length (0 to n)
        # j: current maximum value (0 to m)
        # c: current number of search cost (0 to k)
        dp = [[[0] * (k + 1) for _ in range(m + 1)] for _ in range(n + 1)]

        # Base case: For an array of length 1, with max_val j, and 1 comparison.
        # There is 1 way: the array is [j].
        for j in range(1, m + 1):
            dp[1][j][1] = 1

        # Fill the DP table
        for i in range(2, n + 1):  # Current array length
            for c in range(1, k + 1):  # Current number of comparisons
                # sum_prev_max_for_new_max will store sum(dp[i-1][prev_max][c-1] for prev_max in range(1, j_curr))
                # This is for Option 1, where the current element 'j_curr' is a new maximum.
                sum_prev_max_for_new_max = 0 
                for j_curr in range(1, m + 1):  # Current maximum value

                    # Option 1: The i-th element is j_curr, and j_curr is a new maximum.
                    # This means the previous i-1 elements had a maximum < j_curr, and c-1 comparisons.
                    # sum_prev_max_for_new_max already holds sum(dp[i-1][x][c-1] for x in range(1, j_curr))
                    # If c=1, then c-1=0. dp[...][...][0] is 0, so sum_prev_max_for_new_max will be 0,
                    # correctly reflecting that 0 comparisons for i-1 elements is impossible.
                    dp[i][j_curr][c] = (dp[i][j_curr][c] + sum_prev_max_for_new_max) % MOD

                    # Option 2: The i-th element is x (1 <= x <= j_curr), and j_curr was already the maximum.
                    # This means the previous i-1 elements had j_curr as the maximum, and c comparisons.
                    # There are j_curr choices for the current element (1 to j_curr).
                    dp[i][j_curr][c] = (dp[i][j_curr][c] + dp[i-1][j_curr][c] * j_curr) % MOD

                    # Update sum_prev_max_for_new_max for the next iteration of j_curr.
                    # It needs to include dp[i-1][j_curr][c-1] for the next j_curr calculation.
                    # If c=1, then c-1=0. dp[i-1][j_curr][0] is 0, so sum_prev_max_for_new_max will correctly remain 0.
                    sum_prev_max_for_new_max = (sum_prev_max_for_new_max + dp[i-1][j_curr][c-1]) % MOD

        # The final answer is the sum of all ways to build an array of length n,
        # with any maximum value from 1 to m, using exactly k comparisons.
        ans = 0
        for j in range(1, m + 1):
            ans = (ans + dp[n][j][k]) % MOD

        return ans
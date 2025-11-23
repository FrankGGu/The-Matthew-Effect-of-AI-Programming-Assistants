class Solution:
    def countHousePlacements(self, n: int) -> int:
        MOD = 10**9 + 7

        # dp[i] represents the number of ways to place houses on i plots
        # for a single side of the street such that no two houses are adjacent.
        # dp[0] = 1 (one way for 0 plots: do nothing)
        # dp[1] = 2 (two ways for 1 plot: place a house 'H' or leave empty '_')
        # For i > 1, dp[i] = dp[i-1] + dp[i-2]
        # This is because for the i-th plot:
        # 1. If we place a house, the (i-1)-th plot must be empty.
        #    The number of ways is dp[i-2] (ways to arrange houses on i-2 plots).
        # 2. If we leave the i-th plot empty, the (i-1)-th plot can be either
        #    a house or empty. The number of ways is dp[i-1] (ways to arrange houses on i-1 plots).

        # Initialize for n=0 and n=1
        # dp_prev_prev stores dp[i-2]
        # dp_prev stores dp[i-1]
        dp_prev_prev = 1  # Corresponds to dp[0]
        dp_prev = 2       # Corresponds to dp[1]

        # Since n >= 1 according to constraints, the loop starts from i=2.
        # If n=1, the loop range(2, 1+1) i.e. range(2,2) will not execute.
        # In this case, dp_prev (which is 2) will correctly be the number of ways for n=1.
        for i in range(2, n + 1):
            current_dp = (dp_prev_prev + dp_prev) % MOD
            dp_prev_prev = dp_prev
            dp_prev = current_dp

        # After the loop, dp_prev holds dp[n], which is the number of ways for one side.
        ways_one_side = dp_prev

        # Since there are two sides (street and opposite side) and choices are independent,
        # the total number of ways is (ways_one_side * ways_one_side).
        return (ways_one_side * ways_one_side) % MOD
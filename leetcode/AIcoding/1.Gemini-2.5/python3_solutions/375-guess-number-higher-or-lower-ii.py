class Solution:
    def getMoneyAmount(self, n: int) -> int:
        # dp[i][j] represents the minimum cost to guarantee a win for the numbers in the range [i, j].
        # Initialize dp table with zeros. dp[x][y] = 0 if x >= y (empty or single-number range).
        dp = [[0] * (n + 1) for _ in range(n + 1)]

        # Iterate over the length of the interval.
        # Length 1 intervals (i.e., i=j) are already initialized to 0.
        # We start with length 2 intervals.
        for length in range(2, n + 1):
            # Iterate over the starting point 'i' of the interval.
            # The ending point 'j' is determined by 'i' and 'length'.
            for i in range(1, n - length + 2):
                j = i + length - 1

                # Initialize dp[i][j] to infinity to find the minimum cost.
                dp[i][j] = float('inf')

                # Iterate over all possible guess 'k' within the interval [i, j].
                for k in range(i, j + 1):
                    # If we guess 'k':
                    # We pay 'k'.
                    # If the actual number is lower than 'k', we must solve the subproblem for [i, k-1].
                    # If the actual number is higher than 'k', we must solve the subproblem for [k+1, j].
                    # To guarantee a win, we must account for the worst-case scenario,
                    # which is the maximum of the costs for the two subproblems.
                    # Note: dp[i][k-1] will be 0 if k-1 < i (i.e., k=i, left subproblem is empty).
                    # Note: dp[k+1][j] will be 0 if k+1 > j (i.e., k=j, right subproblem is empty).

                    cost_if_lower = dp[i][k-1]
                    cost_if_higher = dp[k+1][j]

                    current_guess_cost = k + max(cost_if_lower, cost_if_higher)

                    # Update dp[i][j] with the minimum cost found so far for this interval.
                    dp[i][j] = min(dp[i][j], current_guess_cost)

        # The result is the minimum cost to guarantee a win for the entire range [1, n].
        return dp[1][n]
class Solution:
    def pathsDivisibleByK(self, grid: list[list[int]], k: int) -> int:
        m = len(grid)
        n = len(grid[0])
        MOD = 10**9 + 7

        # dp[r][c][rem] stores the number of paths from (0,0) to (r,c)
        # such that the sum of elements along the path modulo k is 'rem'.
        dp = [[[0] * k for _ in range(n)] for _ in range(m)]

        # Base case: starting cell (0,0)
        # The sum is just grid[0][0], so its remainder is grid[0][0] % k
        dp[0][0][grid[0][0] % k] = 1

        # Fill the DP table
        for r in range(m):
            for c in range(n):
                # Skip the base case as it's already handled
                if r == 0 and c == 0:
                    continue

                current_val = grid[r][c]

                # Iterate through all possible previous remainders
                for prev_rem in range(k):
                    # Calculate the new remainder if we add current_val
                    target_rem = (prev_rem + current_val) % k

                    # If coming from the cell above (r-1, c)
                    if r > 0:
                        dp[r][c][target_rem] = (dp[r][c][target_rem] + dp[r-1][c][prev_rem]) % MOD

                    # If coming from the cell to the left (r, c-1)
                    if c > 0:
                        dp[r][c][target_rem] = (dp[r][c][target_rem] + dp[r][c-1][prev_rem]) % MOD

        # The result is the number of paths to (m-1, n-1) with a remainder of 0
        return dp[m-1][n-1][0]
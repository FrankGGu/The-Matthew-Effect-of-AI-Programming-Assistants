import math

class Solution:
    def mergeStones(self, stones: list[int], K: int) -> int:
        n = len(stones)

        # If it's impossible to merge all stones into one pile
        # The number of piles reduces by (K-1) in each merge.
        # To get 1 pile from n piles, we need to perform (n-1) merges.
        # So (n-1) must be a multiple of (K-1).
        if (n - 1) % (K - 1) != 0:
            return -1

        # dp[i][j][p] = min cost to merge stones[i...j] into p piles
        # Initialize with infinity
        dp = [[[math.inf] * (K + 1) for _ in range(n)] for _ in range(n)]

        # Base case: cost to merge a single stone into 1 pile is 0
        for i in range(n):
            dp[i][i][1] = 0

        # Precompute prefix sums for efficient sum calculation
        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i+1] = prefix_sum[i] + stones[i]

        # Iterate over length of subarray
        for length in range(2, n + 1):
            # Iterate over starting index
            for i in range(n - length + 1):
                j = i + length - 1 # Ending index

                # Iterate over number of piles (p > 1)
                # To form 'p' piles from stones[i...j], we split it into two parts:
                # stones[i...m] forming 'p-1' piles and stones[m+1...j] forming '1' pile.
                for p in range(2, K + 1):
                    # Check if it's possible to form 'p' piles from 'length' stones
                    # (length - p) must be a multiple of (K - 1)
                    if (length - p) % (K - 1) != 0:
                        continue

                    for m in range(i, j): # Split point
                        # Ensure both subproblems are solvable
                        if dp[i][m][p-1] != math.inf and dp[m+1][j][1] != math.inf:
                            dp[i][j][p] = min(dp[i][j][p], dp[i][m][p-1] + dp[m+1][j][1])

                # After computing for p > 1, compute for p = 1
                # To form 1 pile from stones[i...j], we must have exactly K piles first,
                # then merge those K piles into 1.
                if (length - 1) % (K - 1) == 0:
                    if dp[i][j][K] != math.inf:
                        # The cost of merging K piles into 1 is the sum of all stones in this range
                        dp[i][j][1] = dp[i][j][K] + (prefix_sum[j+1] - prefix_sum[i])

        # The final answer is the minimum cost to merge all stones (0 to n-1) into 1 pile
        return dp[0][n-1][1] if dp[0][n-1][1] != math.inf else -1
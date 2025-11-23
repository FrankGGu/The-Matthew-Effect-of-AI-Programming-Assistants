import math

class Solution:
    def stoneGameV(self, stoneValue: list[int]) -> int:
        n = len(stoneValue)

        # prefix_sum[i] stores the sum of stoneValue[0...i-1]
        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i+1] = prefix_sum[i] + stoneValue[i]

        # dp[i][j] stores the maximum score Alice can get from the subarray stoneValue[i...j]
        dp = [[0] * n for _ in range(n)]

        # Iterate over length of the subarray
        for length in range(2, n + 1):
            # Iterate over starting index i
            for i in range(n - length + 1):
                j = i + length - 1  # Ending index j

                # Alice tries all possible split points k
                # k is the last index of the left pile
                # Left pile: stoneValue[i...k]
                # Right pile: stoneValue[k+1...j]

                # Initialize dp[i][j] to 0, as scores are non-negative
                dp[i][j] = 0 

                for k in range(i, j):
                    sum_left = prefix_sum[k+1] - prefix_sum[i]
                    sum_right = prefix_sum[j+1] - prefix_sum[k+1]

                    current_score = 0
                    if sum_left < sum_right:
                        # Alice gets sum_left points, and the game continues on the left pile
                        current_score = sum_left + dp[i][k]
                    elif sum_right < sum_left:
                        # Alice gets sum_right points, and the game continues on the right pile
                        current_score = sum_right + dp[k+1][j]
                    else: # sum_left == sum_right
                        # Alice gets sum_left points, and the game continues on both piles
                        current_score = sum_left + dp[i][k] + dp[k+1][j]

                    dp[i][j] = max(dp[i][j], current_score)

        return dp[0][n-1]
class Solution:
    def PredictTheWinner(self, nums: List[int]) -> bool:
        n = len(nums)

        if n % 2 == 0:
            return True

        dp = [[0] * n for _ in range(n)]

        for i in range(n):
            dp[i][i] = nums[i]

        for length in range(2, n + 1):
            for i in range(n - length + 1):
                j = i + length - 1
                # If current player takes nums[i], their score increases by nums[i].
                # The next player will then play on nums[i+1...j], and dp[i+1][j]
                # represents the maximum score difference the next player can achieve.
                # From the current player's perspective, this means their score difference
                # will be reduced by dp[i+1][j].
                score_if_take_left = nums[i] - dp[i+1][j]

                # If current player takes nums[j], similar logic applies.
                score_if_take_right = nums[j] - dp[i][j-1]

                # The current player chooses the move that maximizes their score difference.
                dp[i][j] = max(score_if_take_left, score_if_take_right)

        # Player 1 wins if their score difference (P1_score - P2_score) is non-negative.
        return dp[0][n-1] >= 0
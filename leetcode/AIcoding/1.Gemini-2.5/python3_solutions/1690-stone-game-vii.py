class Solution:
    def stoneGameVII(self, stones: list[int]) -> int:
        n = len(stones)

        # dp[i][j] represents the maximum score difference Alice can achieve
        # when playing optimally with the subarray stones[i...j].
        # Alice wants to maximize (Alice's score - Bob's score).
        # Bob wants to maximize (Bob's score - Alice's score), which is
        # equivalent to minimizing (Alice's score - Bob's score).
        # So, if it's Alice's turn, she maximizes her current stone value + (score_diff from Bob's turn)
        # If it's Bob's turn, he maximizes his current stone value + (score_diff from Alice's turn)
        # This translates to:
        # dp[i][j] = max(stones[i] - dp[i+1][j], stones[j] - dp[i][j-1])
        # The base case is when there are fewer than two stones, meaning j <= i.
        # In this case, no more moves can be made, so the score difference is 0.

        dp = [[0] * n for _ in range(n)]

        # Iterate over the length of the subarray (L)
        # L goes from 2 to n, because subarrays of length 1 (j == i) are base cases (0 difference).
        for length in range(2, n + 1):
            # Iterate over the starting index (i)
            # The ending index j can be calculated as i + length - 1
            for i in range(n - length + 1):
                j = i + length - 1

                # Alice's choice:
                # 1. Take stones[i]: Her score increases by stones[i].
                #    The remaining game is stones[i+1...j]. Now it's Bob's turn.
                #    Bob will play to minimize Alice's score difference, so he achieves -dp[i+1][j].
                #    Alice's total score difference for this choice: stones[i] - dp[i+1][j].
                # 2. Take stones[j]: Her score increases by stones[j].
                #    The remaining game is stones[i...j-1]. Now it's Bob's turn.
                #    Bob will play to minimize Alice's score difference, so he achieves -dp[i][j-1].
                #    Alice's total score difference for this choice: stones[j] - dp[i][j-1].

                dp[i][j] = max(stones[i] - dp[i+1][j], stones[j] - dp[i][j-1])

        return dp[0][n-1]
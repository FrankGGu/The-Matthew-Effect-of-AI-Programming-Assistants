class Solution:
    def stoneGameIII(self, stoneValue: list[int]) -> str:
        n = len(stoneValue)

        # dp[i] represents the maximum score difference (Alice's score - Bob's score)
        # that the current player can achieve if the game starts from index i.
        # We initialize with n+3 to handle potential out-of-bounds access for i+1, i+2, i+3
        # where dp[n], dp[n+1], dp[n+2] would be 0 (no stones left, no score difference).
        dp = [0] * (n + 3)

        # Iterate from the end of the stoneValue array backwards
        for i in range(n - 1, -1, -1):
            current_sum = 0

            # Option 1: Take 1 stone
            # Alice takes stoneValue[i], then Bob plays from i+1.
            # Bob will play to maximize his score - Alice's score, which is dp[i+1].
            # So, from Alice's perspective, she gets stoneValue[i] and then loses dp[i+1].
            current_sum += stoneValue[i]
            max_diff_for_alice = current_sum - dp[i+1]

            # Option 2: Take 2 stones
            # Alice takes stoneValue[i] + stoneValue[i+1], then Bob plays from i+2.
            if i + 1 < n:
                current_sum += stoneValue[i+1]
                max_diff_for_alice = max(max_diff_for_alice, current_sum - dp[i+2])

            # Option 3: Take 3 stones
            # Alice takes stoneValue[i] + stoneValue[i+1] + stoneValue[i+2], then Bob plays from i+3.
            if i + 2 < n:
                current_sum += stoneValue[i+2]
                max_diff_for_alice = max(max_diff_for_alice, current_sum - dp[i+3])

            dp[i] = max_diff_for_alice

        # dp[0] contains the maximum score difference Alice can achieve starting from the beginning.
        if dp[0] > 0:
            return "Alice"
        elif dp[0] < 0:
            return "Bob"
        else:
            return "Tie"
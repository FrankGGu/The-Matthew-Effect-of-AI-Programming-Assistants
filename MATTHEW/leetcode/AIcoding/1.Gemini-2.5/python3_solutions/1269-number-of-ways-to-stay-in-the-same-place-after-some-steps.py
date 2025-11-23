class Solution:
    def numWays(self, steps: int, arrLen: int) -> int:
        MOD = 10**9 + 7

        # The maximum position we need to consider is limited by two factors:
        # 1. We cannot go beyond arrLen - 1.
        # 2. To return to index 0 after 'steps' steps, if we move 'k' steps to the right,
        #    we must also move 'k' steps to the left. This means 2 * k <= steps, so k <= steps // 2.
        #    Thus, the furthest index we can be at and still return to 0 is steps // 2.
        # We take the minimum of these two limits.
        # The number of columns in our DP table will be `max_reachable_idx + 1`
        # because indices are 0-based.
        max_reachable_idx = min(arrLen - 1, steps // 2)
        num_cols = max_reachable_idx + 1

        # dp[j] represents the number of ways to be at index j after the current step.
        # We use two arrays (prev_dp and curr_dp) for space optimization,
        # as the current state only depends on the previous state.
        prev_dp = [0] * num_cols
        prev_dp[0] = 1  # Base case: 1 way to be at index 0 after 0 steps

        for s in range(1, steps + 1):
            curr_dp = [0] * num_cols
            for j in range(num_cols):
                # Option 1: Stay at current position j
                curr_dp[j] = prev_dp[j]

                # Option 2: Come from position j-1 (by moving right from j-1)
                if j > 0:
                    curr_dp[j] = (curr_dp[j] + prev_dp[j-1]) % MOD

                # Option 3: Come from position j+1 (by moving left from j+1)
                # Check if j+1 is within the bounds of our considered columns
                if j < num_cols - 1:
                    curr_dp[j] = (curr_dp[j] + prev_dp[j+1]) % MOD

            prev_dp = curr_dp

        # After 'steps' steps, the number of ways to be at index 0 is prev_dp[0]
        return prev_dp[0]
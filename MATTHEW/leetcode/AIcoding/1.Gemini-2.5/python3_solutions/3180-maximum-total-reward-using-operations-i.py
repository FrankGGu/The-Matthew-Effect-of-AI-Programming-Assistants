class Solution:
    def maxTotalReward(self, reward: list[int]) -> int:
        reward.sort()

        # The maximum possible reward X is bounded.
        # If X is the maximum reward, it must be formed as s + r_k
        # where s is a previously achievable sum and s < r_k.
        # Since r_k is an element of the reward array, r_k <= max(reward).
        # Therefore, X = s + r_k < r_k + r_k = 2 * r_k.
        # So, X < 2 * max(reward).
        # Given max(reward[i]) can be up to 2000, X < 2 * 2000 = 4000.

        # Find the maximum value in reward to determine dp array size.
        # Problem constraints state reward[i] >= 1, so reward is never empty and max_r >= 1.
        max_r = reward[-1] 

        # dp[s] will be True if sum 's' is achievable, False otherwise.
        # The maximum sum we need to store is 2 * max_r - 1.
        # So, a dp array of size 2 * max_r (indices 0 to 2*max_r - 1) is sufficient.
        dp_size = 2 * max_r
        dp = [False] * dp_size
        dp[0] = True  # Initial state: x = 0 is achievable.

        for r in reward:
            # Iterate 's' from largest possible sum down to 0.
            # This ensures that for a given 'r', we only use sums 's' that were
            # achievable *before* considering 'r' for the current iteration.
            # If we iterate upwards, dp[s+r] might be set to True and then used
            # to form dp[s+r+r] within the same iteration of 'r', which is incorrect
            # as each reward can be used at most once.

            # We only need to consider 's' such that 's + r' is within dp_size.
            # So, 's' must be less than 'dp_size - r'.
            # Also, 's' must be less than 'r' as per the problem rule.
            # The loop range for 's' can be optimized to `min(dp_size - 1 - r, r - 1)` down to 0.
            # However, iterating from `dp_size - 1` down to `0` and applying conditions
            # `s < r` and `s + r < dp_size` is also correct and sometimes simpler to reason about.
            for s in range(dp_size - 1, -1, -1):
                if dp[s]:  # If 's' is an achievable sum
                    if s < r:  # And 'r' can be added to 's' (reward[i] > x)
                        if s + r < dp_size:  # And the new sum is within our dp bounds
                            dp[s + r] = True

        # After processing all rewards, find the largest 's' for which dp[s] is True.
        # This will be the maximum total reward.
        for s in range(dp_size - 1, -1, -1):
            if dp[s]:
                return s

        # This line should theoretically not be reached because dp[0] is always True.
        return 0
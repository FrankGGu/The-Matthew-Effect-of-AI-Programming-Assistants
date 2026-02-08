class Solution:
    def maxTotalReward(self, rewardValues: list[int]) -> int:
        rewards = sorted(list(set(rewardValues)))

        max_reward_val = rewards[-1]

        # The maximum possible total reward is strictly less than 2 * max_reward_val.
        # This is because if an accumulated sum `s` is greater than or equal to `max_reward_val`,
        # it's impossible to add any further reward `r` since all `r` in `rewardValues` are
        # less than or equal to `max_reward_val`, violating the `r > s` condition.
        # Thus, the sum before the last chosen reward must be less than `max_reward_val`.
        # The final sum will be `(sum < max_reward_val) + (last_reward <= max_reward_val)`,
        # which is strictly less than `max_reward_val + max_reward_val = 2 * max_reward_val`.
        dp_size = 2 * max_reward_val 

        # dp[s] is True if sum `s` is achievable, False otherwise.
        # Initialize dp with False, and dp[0] = True (representing an empty set sum).
        dp = [False] * dp_size
        dp[0] = True

        # Iterate through each unique and sorted reward value.
        for r in rewards:
            # Iterate through possible sums `s` in reverse.
            # This ensures that when we consider `r`, `dp[s]` refers to sums achievable
            # *before* considering the current `r`. If we iterate forwards,
            # `dp[s]` might already include `r` from the current iteration,
            # which would effectively allow using `r` multiple times in a single step.
            for s in range(dp_size - 1, -1, -1):
                if dp[s]:  # If sum `s` is achievable
                    # If the current reward `r` is strictly greater than `s`,
                    # we can form a new sum `s + r`.
                    if r > s:
                        # Check bounds for `s + r` to prevent index out of bounds.
                        # This is implicitly handled by `dp_size` definition, but good practice.
                        if s + r < dp_size:
                            dp[s + r] = True

        # The maximum total reward is the largest `s` for which `dp[s]` is True.
        # Iterate from `dp_size - 1` down to `0` to find the largest achievable sum.
        for s in range(dp_size - 1, -1, -1):
            if dp[s]:
                return s

        # This line should theoretically not be reached because dp[0] is always True.
        return 0
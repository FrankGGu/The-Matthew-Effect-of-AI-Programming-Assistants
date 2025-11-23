class Solution:
    def stoneGameVIII(self, stones: list[int]) -> int:
        n = len(stones)

        prefixSums = [0] * n
        prefixSums[0] = stones[0]
        for i in range(1, n):
            prefixSums[i] = prefixSums[i-1] + stones[i]

        # dp[i] represents the maximum score difference Alice can achieve
        # if the game starts with piles i, i+1, ..., n-1 available.
        # The recurrence relation is dp[i] = max_{j=i}^{n-1} (prefixSums[j] - dp[j+1]).
        # The base case is dp[n] = 0.

        # We can optimize the calculation of `max_{j=i}^{n-1} (prefixSums[j] - dp[j+1])`
        # by iterating backwards and maintaining a suffix maximum.
        # Let `max_suffix_diff` store `max_{k=i}^{n-1} (prefixSums[k] - dp[k+1])`.

        # Initialize for the last possible state, i = n-1.
        # If n=1, the loop range `range(n-2, -1, -1)` will be empty.
        # In this case, Alice picks stones[0], gets prefixSums[0], Bob gets 0.
        # The difference is prefixSums[0].
        # The initialization below handles this correctly.

        # dp[n] is 0.
        # For i = n-1, Alice can only pick pile n-1.
        # Her score difference is prefixSums[n-1] - dp[n] = prefixSums[n-1] - 0.
        # So, dp[n-1] = prefixSums[n-1].
        # `max_suffix_diff` will start by holding this value, which is `dp[n-1]`.

        # `dp_val_at_n` represents `dp[n]`, which is 0.
        dp_val_at_n = 0 
        max_suffix_diff = prefixSums[n-1] - dp_val_at_n

        # Iterate from i = n-2 down to 0.
        # In each iteration, `max_suffix_diff` from the previous step represents `dp[i+1]`.
        # We need to calculate `dp[i] = max(prefixSums[i] - dp[i+1], dp[i+1])`
        # where `dp[i+1]` is the maximum difference from `i+1` onwards.
        # More precisely, `dp[i] = max(prefixSums[i] - dp[i+1], max_{k=i+1}^{n-1} (prefixSums[k] - dp[k+1]))`.
        # The `max_suffix_diff` variable already stores `max_{k=i+1}^{n-1} (prefixSums[k] - dp[k+1])` from the previous iteration.

        for i in range(n - 2, -1, -1):
            # `current_choice_diff` is the score difference if Alice chooses pile `i`.
            # This is `prefixSums[i] - dp[i+1]`.
            # Here, `dp[i+1]` is the `max_suffix_diff` calculated in the previous iteration (which was `dp[i+1]`).
            current_choice_diff = prefixSums[i] - max_suffix_diff

            # `max_suffix_diff` for the current `i` is the maximum of:
            # 1. The difference if Alice chooses pile `i` (`current_choice_diff`).
            # 2. The maximum difference if Alice chooses any pile `j > i` (which is the `max_suffix_diff` from the previous iteration).
            max_suffix_diff = max(max_suffix_diff, current_choice_diff)

        # The final `max_suffix_diff` will hold `dp[0]`, which is the answer.
        return max_suffix_diff
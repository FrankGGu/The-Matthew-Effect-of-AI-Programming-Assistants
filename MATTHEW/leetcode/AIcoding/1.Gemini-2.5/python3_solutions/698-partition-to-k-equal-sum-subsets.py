class Solution:
    def canPartitionKSubsets(self, nums: list[int], k: int) -> bool:
        total_sum = sum(nums)
        if total_sum % k != 0:
            return False

        target_sum = total_sum // k

        n = len(nums)

        # dp[mask] stores a tuple (num_completed_subsets, current_subset_sum)
        # num_completed_subsets: how many subsets of `target_sum` have been perfectly formed.
        # current_subset_sum: the sum of elements currently being accumulated for the *current* subset.
        # Initialize with (-1, -1) to indicate unreachable states.
        dp = [(-1, -1)] * (1 << n)

        # Base case: empty mask, 0 subsets completed, current subset sum is 0.
        dp[0] = (0, 0)

        # Iterate through all possible masks (subsets of nums)
        for mask in range(1 << n):
            # If this mask is not reachable, skip it.
            if dp[mask] == (-1, -1):
                continue

            num_completed, current_sum = dp[mask]

            # Try to add each number not yet in the current mask
            for i in range(n):
                # Check if nums[i] is not included in the current mask
                if not ((mask >> i) & 1):
                    next_mask = mask | (1 << i)
                    new_sum = current_sum + nums[i]

                    # If adding nums[i] exceeds the target_sum for a subset, skip.
                    if new_sum > target_sum:
                        continue

                    if new_sum == target_sum:
                        # We have successfully formed one more subset.
                        # Start a new subset with sum 0.
                        new_state = (num_completed + 1, 0)
                    else:
                        # Continue building the current subset.
                        new_state = (num_completed, new_sum)

                    # Update dp[next_mask] if this new_state is better.
                    # A state is better if:
                    # 1. More subsets are completed.
                    # 2. Same number of subsets completed, but current_subset_sum is smaller.
                    #    (This helps in finding a solution faster or ensuring a valid path.
                    #    If a state (c,s) is reached, and another path reaches (c,s'),
                    #    and s' < s, then (c,s') is preferred as it has more room for future elements.)
                    prev_completed, prev_sum = dp[next_mask]

                    if prev_completed == -1 or \
                       new_state[0] > prev_completed or \
                       (new_state[0] == prev_completed and new_state[1] < prev_sum):
                        dp[next_mask] = new_state

        # After iterating through all masks, check the final state where all numbers are used.
        final_mask = (1 << n) - 1
        final_completed, final_sum = dp[final_mask]

        # We need to have exactly k subsets completed, and the last subset must also sum to 0
        # (meaning it was perfectly filled to target_sum).
        return final_completed == k and final_sum == 0
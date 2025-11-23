import collections

class Solution:
    def minChanges(self, nums: list[int], k: int) -> int:
        MAX_XOR = 1023  # Max possible XOR sum, as nums[i] <= 1000, 2^10 - 1 = 1023
        M = MAX_XOR + 1

        n = len(nums)

        # Step 1: Group numbers by their index modulo k and count frequencies
        # freqs[i] stores a dictionary of {value: count} for group i
        # group_lens[i] stores the total number of elements in group i
        freqs = [collections.defaultdict(int) for _ in range(k)]
        group_lens = [0] * k

        for idx, num in enumerate(nums):
            group_idx = idx % k
            freqs[group_idx][num] += 1
            group_lens[group_idx] += 1

        # Step 2: Initialize DP table for the first group (i=0)
        # dp[xor_sum] stores the minimum changes to make the XOR sum of the first 'i' groups equal to xor_sum
        dp = [float('inf')] * M

        # Cost function for a single group 'j' to have XOR sum 'x':
        # If group_lens[j] == 1:
        #   Cost is 0 if the single element is 'x'.
        #   Cost is 1 if the single element is not 'x'.
        # If group_lens[j] > 1:
        #   Cost is group_lens[j] - 1 for any 'x'. (By changing all but one element, which is always possible)

        if group_lens[0] == 1:
            # Group 0 has only one element. Let it be `val`.
            # If we want its XOR sum to be `val`, cost is 0. Else cost is 1.
            val_in_group_0 = next(iter(freqs[0].keys())) 
            dp[val_in_group_0] = 0
            for xor_val in range(M):
                if xor_val != val_in_group_0:
                    dp[xor_val] = 1
        else: # group_lens[0] > 1
            # Cost is `group_lens[0] - 1` for any target XOR sum.
            cost_for_group_0 = group_lens[0] - 1
            for xor_val in range(M):
                dp[xor_val] = cost_for_group_0

        # Step 3: Iterate through the remaining groups (i=1 to k-1)
        for i in range(1, k):
            new_dp = [float('inf')] * M

            # min_prev_dp_val is the minimum cost to achieve any XOR sum for the first (i-1) groups.
            # This is used for the "general cost" strategy.
            min_prev_dp_val = min(dp)

            if group_lens[i] == 1:
                # For this group, the cost is 0 if target_xor_sum is the single element, else 1.
                val_in_group_i = next(iter(freqs[i].keys())) # Get the single value

                # Strategy 1: Target XOR sum for current group is `val_in_group_i` (cost 0 for this group)
                cost_for_this_group_0_changes = 0
                for prev_xor_sum in range(M):
                    current_xor_sum = prev_xor_sum ^ val_in_group_i
                    new_dp[current_xor_sum] = min(new_dp[current_xor_sum], dp[prev_xor_sum] + cost_for_this_group_0_changes)

                # Strategy 2: Target XOR sum for current group is NOT `val_in_group_i` (cost 1 for this group)
                # This applies to all other XOR sums.
                cost_for_this_group_1_change = 1
                for current_xor_sum in range(M):
                    # We can achieve any current_xor_sum by taking min_prev_dp_val
                    # and paying 1 for this group.
                    new_dp[current_xor_sum] = min(new_dp[current_xor_sum], min_prev_dp_val + cost_for_this_group_1_change)

            else: # group_lens[i] > 1
                # For this group, the cost is always `group_lens[i] - 1` for any target XOR sum.
                cost_for_this_group = group_lens[i] - 1
                for current_xor_sum in range(M):
                    # We can achieve any current_xor_sum by taking min_prev_dp_val
                    # and paying `cost_for_this_group` for this group.
                    new_dp[current_xor_sum] = min_prev_dp_val + cost_for_this_group

            dp = new_dp

        # The final answer is the minimum changes to make the total XOR sum equal to 0
        return dp[0]
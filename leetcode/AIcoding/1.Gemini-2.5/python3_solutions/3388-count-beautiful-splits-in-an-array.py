import collections

class Solution:
    def beautifulSplits(self, nums: list[int]) -> int:
        n = len(nums)
        if n < 2:
            return 0

        p_ones = [0] * n
        current_count = 0
        for k in range(n):
            if nums[k] == 1:
                current_count += 1
            p_ones[k] = current_count

        s_ones = [0] * n
        current_count = 0
        for k in range(n - 1, -1, -1):
            if nums[k] == 1:
                current_count += 1
            s_ones[k] = current_count

        beautiful_splits_count = 0

        right_suffix_ones_counts = collections.Counter()
        # Initialize right_suffix_ones_counts for j from 1 to n-1
        # These are the potential 'j' indices for the first 'i' (which is 0)
        for k in range(1, n):
            if nums[k] == 1:
                right_suffix_ones_counts[s_ones[k]] += 1

        # Iterate i from 0 to n-2 (the first index of the split)
        for i in range(n - 1):
            # If nums[i] is 1, it can be the start of a beautiful split
            if nums[i] == 1:
                target_p_ones = p_ones[i]
                beautiful_splits_count += right_suffix_ones_counts.get(target_p_ones, 0)

            # Update right_suffix_ones_counts for the next iteration (i+1)
            # For the next 'i', 'j' must be strictly greater than 'i+1'.
            # So, we remove s_ones[i+1] from the counts if nums[i+1] was 1.
            if i + 1 < n and nums[i+1] == 1:
                right_suffix_ones_counts[s_ones[i+1]] -= 1
                if right_suffix_ones_counts[s_ones[i+1]] == 0:
                    del right_suffix_ones_counts[s_ones[i+1]]

        return beautiful_splits_count
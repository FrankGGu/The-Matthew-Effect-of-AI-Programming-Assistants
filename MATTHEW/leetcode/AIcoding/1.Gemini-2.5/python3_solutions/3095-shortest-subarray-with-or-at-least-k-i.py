class Solution:
    def shortestSubarrayWithOR(self, nums: list[int], k: int) -> int:
        min_len = float('inf')

        # dp stores pairs of (current_or_value, start_index)
        # For a given j, dp[i] represents the bitwise OR sum of a subarray ending at j.
        # The list is maintained such that start_indices are strictly decreasing from left to right,
        # and corresponding OR values are non-decreasing.
        # For any distinct OR value, we store the smallest (leftmost) start_index.
        dp = [] 

        for j in range(len(nums)):
            # Create a new list for OR sums ending at current index j
            next_dp = []

            # Subarray consisting of only nums[j]
            # This will always be the rightmost subarray, so its start_index is j.
            next_dp.append((nums[j], j))

            # Extend previous subarrays ending at j-1 by including nums[j]
            for prev_or_val, prev_start_idx in dp:
                current_or_val = prev_or_val | nums[j]

                # If the current_or_val is the same as the last one added to next_dp,
                # it means we found a subarray (ending at j, starting at prev_start_idx)
                # that has the same OR sum as a previously found subarray (ending at j).
                # Since we iterate dp from left to right, prev_start_idx is smaller
                # than the start_index of next_dp[-1] (which came from an earlier prev_start_idx or j itself).
                # To maintain the property of smallest start_index for a given OR value,
                # we update next_dp[-1] with the smaller prev_start_idx.
                if current_or_val == next_dp[-1][0]:
                    next_dp[-1] = (current_or_val, prev_start_idx)
                else:
                    # New distinct OR value, append it.
                    next_dp.append((current_or_val, prev_start_idx))

            dp = next_dp

            # Check for subarrays ending at j that satisfy the condition
            # Iterate through all (or_val, start_idx) pairs in dp.
            # For each pair, if or_val >= k, calculate the length and update min_len.
            for or_val, start_idx in dp:
                if or_val >= k:
                    min_len = min(min_len, j - start_idx + 1)

        return min_len if min_len != float('inf') else -1
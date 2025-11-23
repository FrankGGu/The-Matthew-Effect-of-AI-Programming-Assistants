class Solution:
    def maxSubsequenceSum(self, nums: list[int]) -> int:
        if not nums:
            return 0

        n = len(nums)
        if n == 1:
            return max(0, nums[0])

        # dp_i_minus_2 represents the maximum sum ending at index i-2 (or before),
        # allowing for an empty subsequence (sum 0).
        dp_i_minus_2 = 0

        # dp_i_minus_1 represents the maximum sum ending at index i-1 (or before),
        # allowing for an empty subsequence (sum 0).
        # For the first element, it's either nums[0] or 0 (empty subsequence).
        dp_i_minus_1 = max(0, nums[0])

        for i in range(1, n):
            # Option 1: Include nums[i]. If we include nums[i], we cannot include nums[i-1].
            # So, the sum would be nums[i] + dp_i_minus_2.
            # Option 2: Exclude nums[i]. If we exclude nums[i], the max sum up to this point
            # is simply dp_i_minus_1.
            # We also need to ensure the sum is not negative if we can choose not to take any elements.
            current_max = max(nums[i] + dp_i_minus_2, dp_i_minus_1)

            # Update for the next iteration
            dp_i_minus_2 = dp_i_minus_1
            dp_i_minus_1 = current_max

        return dp_i_minus_1
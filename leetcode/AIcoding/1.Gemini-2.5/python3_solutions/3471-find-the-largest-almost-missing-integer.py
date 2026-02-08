class Solution:
    def findLargestAlmostMissingInteger(self, nums: list[int]) -> int:
        if not nums:
            return -1

        num_set = set(nums)

        largest_almost_missing = float('-inf')

        for n in num_set:
            candidate_x = n + 1
            if candidate_x not in num_set:
                largest_almost_missing = max(largest_almost_missing, candidate_x)

        # If nums is empty, max(nums) would fail. Handled by initial check.
        # If nums contains only negative numbers or 0, max(nums) + 1 could be the largest.
        # For example, nums = [-5, -3]. max(nums) = -3. largest_almost_missing would be -2.
        # My loop correctly initializes largest_almost_missing to -inf and then updates it.
        # The largest element in nums, max(nums), will always produce a candidate max(nums) + 1.
        # This candidate is guaranteed not to be in num_set and max(nums) is in num_set.
        # Therefore, max(nums) + 1 is always an almost missing integer if nums is not empty.
        # It's also the largest possible value that can be formed by n+1 where n is in nums,
        # unless there's a larger gap earlier.
        # So, we can initialize largest_almost_missing with max(nums) + 1 directly.

        # Re-initializing with max(nums) + 1 for clarity and correctness.
        # This covers the case where the largest almost missing integer is just one greater than the maximum element.
        largest_almost_missing = max(nums) + 1

        for n in num_set:
            candidate_x = n + 1
            if candidate_x not in num_set:
                largest_almost_missing = max(largest_almost_missing, candidate_x)

        return largest_almost_missing
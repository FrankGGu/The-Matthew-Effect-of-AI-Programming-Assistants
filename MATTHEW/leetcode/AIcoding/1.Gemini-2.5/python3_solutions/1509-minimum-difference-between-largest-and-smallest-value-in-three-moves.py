class Solution:
    def minDifference(self, nums: list[int]) -> int:
        n = len(nums)

        if n <= 4:
            return 0

        nums.sort()

        # We can change up to 3 elements. This means we effectively remove 3 elements.
        # We are left with n - 3 elements.
        # We want to minimize the difference between the maximum and minimum of these n-3 elements.
        # There are four scenarios for which 3 elements to "remove" (by changing their values):

        # Scenario 1: Remove the 3 smallest elements (nums[0], nums[1], nums[2])
        # The remaining range is from nums[3] to nums[n-1].
        diff1 = nums[n-1] - nums[3]

        # Scenario 2: Remove the 2 smallest (nums[0], nums[1]) and 1 largest element (nums[n-1])
        # The remaining range is from nums[2] to nums[n-2].
        diff2 = nums[n-2] - nums[2]

        # Scenario 3: Remove the 1 smallest (nums[0]) and 2 largest elements (nums[n-1], nums[n-2])
        # The remaining range is from nums[1] to nums[n-3].
        diff3 = nums[n-3] - nums[1]

        # Scenario 4: Remove the 3 largest elements (nums[n-1], nums[n-2], nums[n-3])
        # The remaining range is from nums[0] to nums[n-4].
        diff4 = nums[n-4] - nums[0]

        return min(diff1, diff2, diff3, diff4)
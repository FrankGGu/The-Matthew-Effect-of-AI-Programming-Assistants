class Solution:
    def incremovableSubarrayCount(self, nums: List[int]) -> int:
        n = len(nums)
        res = 0

        # Find the longest prefix that is strictly increasing
        prefix = 0
        while prefix < n - 1 and nums[prefix] < nums[prefix + 1]:
            prefix += 1

        # The entire array is strictly increasing
        if prefix == n - 1:
            return n * (n + 1) // 2

        # Find the longest suffix that is strictly increasing
        suffix = n - 1
        while suffix > 0 and nums[suffix - 1] < nums[suffix]:
            suffix -= 1

        res = prefix + 2 + (n - suffix)

        # Check for possible subarrays that connect prefix and suffix
        left = 0
        for right in range(suffix, n):
            while left <= prefix and nums[left] < nums[right]:
                left += 1
            res += left

        return res
class Solution:
    def minimumReplacement(self, nums: List[int]) -> int:
        n = len(nums)
        count = 0
        max_val = nums[-1]

        for i in range(n - 2, -1, -1):
            if nums[i] > max_val:
                count += (nums[i] - 1) // max_val
                max_val = nums[i] // ((nums[i] - 1) // max_val + 1)
            else:
                max_val = nums[i]

        return count
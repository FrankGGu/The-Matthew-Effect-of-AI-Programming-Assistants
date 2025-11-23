class Solution:
    def minOperations(self, nums: List[int]) -> int:
        n = len(nums)
        ops = 0

        for i in range(n - 1, 0, -1):
            if nums[i] < nums[i - 1]:
                ops += nums[i - 1] - nums[i]
                nums[i - 1] = nums[i]

        return ops
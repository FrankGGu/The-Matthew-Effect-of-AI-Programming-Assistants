class Solution:
    def minimumReplacement(self, nums: List[int]) -> int:
        operations = 0
        n = len(nums)
        prev = nums[-1]

        for i in range(n - 2, -1, -1):
            if nums[i] > prev:
                parts = (nums[i] + prev - 1) // prev
                operations += parts - 1
                prev = nums[i] // parts
            else:
                prev = nums[i]

        return operations
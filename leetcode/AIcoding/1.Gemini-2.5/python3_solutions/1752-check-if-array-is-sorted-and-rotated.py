class Solution:
    def check(self, nums: list[int]) -> bool:
        n = len(nums)
        descents = 0
        for i in range(n):
            if nums[i] > nums[(i + 1) % n]:
                descents += 1
        return descents <= 1
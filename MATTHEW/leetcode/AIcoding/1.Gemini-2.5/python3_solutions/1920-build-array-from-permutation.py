class Solution:
    def buildArray(self, nums: list[int]) -> list[int]:
        n = len(nums)
        ans = [0] * n
        for i in range(n):
            ans[i] = nums[nums[i]]
        return ans
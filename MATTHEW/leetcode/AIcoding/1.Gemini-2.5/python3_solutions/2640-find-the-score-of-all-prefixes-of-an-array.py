class Solution:
    def findPrefixScore(self, nums: list[int]) -> list[int]:
        n = len(nums)
        ans = [0] * n
        current_max = 0

        for i in range(n):
            current_max = max(current_max, nums[i])
            ans[i] = nums[i] + current_max

        return ans
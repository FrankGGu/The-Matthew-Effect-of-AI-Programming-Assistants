class Solution:
    def totalSteps(self, nums: List[int]) -> int:
        stack = []
        res = 0
        dp = [0] * len(nums)

        for i in range(len(nums)-1, -1, -1):
            while stack and nums[i] > nums[stack[-1]]:
                dp[i] = max(dp[i] + 1, dp[stack.pop()])
                res = max(res, dp[i])
            stack.append(i)

        return res
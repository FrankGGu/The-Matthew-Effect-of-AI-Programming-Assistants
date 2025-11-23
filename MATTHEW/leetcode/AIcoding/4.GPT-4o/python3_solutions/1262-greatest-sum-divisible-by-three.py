class Solution:
    def maxSumDivThree(self, nums: List[int]) -> int:
        dp = [0] * 3
        for num in nums:
            dp_new = dp[:]
            for i in range(3):
                dp_new[(i + num) % 3] = max(dp_new[(i + num) % 3], dp[i] + num)
            dp = dp_new
        return dp[0]
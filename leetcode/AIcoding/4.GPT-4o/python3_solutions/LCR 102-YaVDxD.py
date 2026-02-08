class Solution:
    def findTargetSumWays(self, nums: List[int], target: int) -> int:
        total = sum(nums)
        if (target + total) % 2 != 0 or target > total:
            return 0
        S = (target + total) // 2
        dp = [0] * (S + 1)
        dp[0] = 1
        for num in nums:
            for j in range(S, num - 1, -1):
                dp[j] += dp[j - num]
        return dp[S]
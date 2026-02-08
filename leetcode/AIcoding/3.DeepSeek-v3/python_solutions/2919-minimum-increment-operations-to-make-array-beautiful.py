class Solution:
    def minIncrementOperations(self, nums: List[int], k: int) -> int:
        n = len(nums)
        dp = [0] * n
        for i in range(n):
            if i < 3:
                dp[i] = max(0, k - nums[i])
            else:
                dp[i] = max(0, k - nums[i]) + min(dp[i-1], dp[i-2], dp[i-3])
        return min(dp[-1], dp[-2], dp[-3]) if n >= 3 else min(dp) if n != 0 else 0
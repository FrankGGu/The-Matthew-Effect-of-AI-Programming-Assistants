class Solution:
    def minimumOperations(self, nums: List[int]) -> int:
        n = len(nums)
        dp = [1] * n
        for i in range(n):
            for j in range(i):
                if nums[j] <= nums[i]:
                    dp[i] = max(dp[i], dp[j] + 1)
        return n - max(dp) if n > 0 else 0
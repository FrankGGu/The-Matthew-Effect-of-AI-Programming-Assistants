class Solution:
    def minIncrementOperations(self, nums: List[int], k: int) -> int:
        n = len(nums)
        dp = [0] * 3
        dp[0] = max(0, k - nums[0])
        if n > 1:
            dp[1] = max(0, k - nums[1])
        if n > 2:
            dp[2] = max(0, k - nums[2])

        for i in range(3, n):
            new_dp = [0] * 3
            new_dp[0] = min(dp[0], dp[1], dp[2]) + max(0, k - nums[i])
            new_dp[1] = dp[0]
            new_dp[2] = dp[1]
            dp = new_dp

        return min(dp[0], dp[1], dp[2])
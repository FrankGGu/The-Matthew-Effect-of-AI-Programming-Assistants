class Solution:
    def maxSumTwoSubarrays(self, nums: List[int], k: int) -> int:
        n = len(nums)
        dp = [0] * n
        current_sum = sum(nums[:k])
        dp[0] = current_sum
        for i in range(1, n - k + 1):
            current_sum = current_sum - nums[i - 1] + nums[i + k - 1]
            dp[i] = current_sum

        max_sum = 0
        for i in range(k, n - k + 1):
            left_max = max(dp[:i - k + 1])
            right_max = max(dp[i + 1:])
            max_sum = max(max_sum, left_max + dp[i])

        return max_sum
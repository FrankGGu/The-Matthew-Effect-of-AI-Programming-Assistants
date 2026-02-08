class Solution:
    def sumOfKSubarrays(self, nums: List[int], k: int, m: int) -> int:
        n = len(nums)
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i+1] = prefix[i] + nums[i]

        dp = [0] * (n + 1)
        res = 0

        for i in range(m, n + 1):
            current_sum = prefix[i] - prefix[i - m]
            if i - m >= k:
                current_sum += dp[i - m]
            if i >= k:
                dp[i] = max(dp[i - 1], current_sum)
            else:
                dp[i] = current_sum

        return dp[n] if n >= k else 0
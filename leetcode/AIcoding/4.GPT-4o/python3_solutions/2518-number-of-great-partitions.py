class Solution:
    def countPartitions(self, nums: List[int], k: int) -> int:
        total_sum = sum(nums)
        if total_sum < k:
            return 0
        mod = 10**9 + 7
        target = (total_sum - k) // 2

        dp = [0] * (target + 1)
        dp[0] = 1

        for num in nums:
            for j in range(target, num - 1, -1):
                dp[j] = (dp[j] + dp[j - num]) % mod

        return (dp[target] * pow(2, nums.count(0), mod)) % mod
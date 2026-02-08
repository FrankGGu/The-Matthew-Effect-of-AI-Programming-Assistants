class Solution:
    def countPartitions(self, nums: List[int], k: int) -> int:
        total_sum = sum(nums)
        if total_sum < 2 * k:
            return 0

        mod = 10**9 + 7
        n = len(nums)
        dp = [0] * k
        dp[0] = 1

        for num in nums:
            for j in range(k - 1, num - 1, -1):
                dp[j] = (dp[j] + dp[j - num]) % mod

        total_subsets = pow(2, n, mod)
        invalid_subsets = (2 * sum(dp)) % mod

        return (total_subsets - invalid_subsets + mod) % mod
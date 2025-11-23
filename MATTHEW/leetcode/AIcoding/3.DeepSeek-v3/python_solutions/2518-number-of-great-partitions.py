class Solution:
    def countPartitions(self, nums: List[int], k: int) -> int:
        MOD = 10**9 + 7
        total = sum(nums)
        if total < 2 * k:
            return 0

        n = len(nums)
        dp = [0] * k
        dp[0] = 1
        res = 0

        for num in nums:
            for j in range(k - 1, num - 1, -1):
                dp[j] = (dp[j] + dp[j - num]) % MOD

        res = pow(2, n, MOD) - 2 * sum(dp) % MOD
        return res % MOD
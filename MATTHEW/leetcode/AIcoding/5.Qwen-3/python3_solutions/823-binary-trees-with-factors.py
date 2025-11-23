class Solution:
    def numFactoredBinaryTrees(self, nums: List[int]) -> int:
        nums.sort()
        index = {num: i for i, num in enumerate(nums)}
        dp = [1] * len(nums)
        MOD = 10**9 + 7
        for j in range(len(nums)):
            for i in range(j):
                if nums[j] % nums[i] == 0:
                    k = index.get(nums[j] // nums[i], -1)
                    if k != -1:
                        dp[j] = (dp[j] + dp[i] * dp[k]) % MOD
        return sum(dp) % MOD
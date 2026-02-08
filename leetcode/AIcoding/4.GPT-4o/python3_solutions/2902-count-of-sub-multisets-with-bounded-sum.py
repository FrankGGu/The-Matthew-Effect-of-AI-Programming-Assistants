class Solution:
    def countSubsets(self, nums: List[int], limit: int) -> int:
        dp = [0] * (limit + 1)
        dp[0] = 1

        for num in nums:
            for j in range(limit, num - 1, -1):
                dp[j] += dp[j - num]

        return sum(dp)
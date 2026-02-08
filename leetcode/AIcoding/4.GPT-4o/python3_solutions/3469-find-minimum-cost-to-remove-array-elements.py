class Solution:
    def findMinimumCost(self, nums: List[int]) -> int:
        count = Counter(nums)
        dp = [0] * (max(count) + 1)

        for i in range(1, len(dp)):
            dp[i] = dp[i - 1]
            if i in count:
                dp[i] = max(dp[i], (count[i] * i) + (dp[i - 2] if i > 1 else 0))

        return dp[-1]
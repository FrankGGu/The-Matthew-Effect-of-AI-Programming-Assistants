class Solution:
    def numberOfArithmeticSlices(self, nums: List[int]) -> int:
        from collections import defaultdict
        n = len(nums)
        dp = [defaultdict(int) for _ in range(n)]
        res = 0
        for i in range(n):
            for j in range(i):
                diff = nums[i] - nums[j]
                dp[i][diff] += dp[j][diff] + 1
                res += dp[j][diff]
        return res
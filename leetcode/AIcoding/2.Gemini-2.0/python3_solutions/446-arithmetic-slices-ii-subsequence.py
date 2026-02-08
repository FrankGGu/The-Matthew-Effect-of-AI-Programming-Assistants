class Solution:
    def numberOfArithmeticSlices(self, nums: list[int]) -> int:
        n = len(nums)
        dp = [{} for _ in range(n)]
        ans = 0
        for i in range(n):
            for j in range(i):
                diff = nums[i] - nums[j]
                if diff in dp[j]:
                    count = dp[j][diff]
                    dp[i][diff] = dp[i].get(diff, 0) + count + 1
                    ans += count
                else:
                    dp[i][diff] = dp[i].get(diff, 0) + 1
        return ans
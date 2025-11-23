class Solution:
    def minCost(self, nums: List[int], k: int) -> int:
        n = len(nums)
        dp = [0] * (n + 1)
        for i in range(1, n + 1):
            dp[i] = dp[i - 1] + k
            count = {}
            trim = 0
            for j in range(i - 1, -1, -1):
                if nums[j] in count:
                    count[nums[j]] += 1
                    if count[nums[j]] == 2:
                        trim += 2
                    elif count[nums[j]] > 2:
                        trim += 1
                else:
                    count[nums[j]] = 1
                dp[i] = min(dp[i], dp[j] + k + trim)
        return dp[n]
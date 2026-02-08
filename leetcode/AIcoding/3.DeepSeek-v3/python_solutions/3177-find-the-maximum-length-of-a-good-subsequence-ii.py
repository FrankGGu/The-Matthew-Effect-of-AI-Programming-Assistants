class Solution:
    def maximumLength(self, nums: List[int], k: int) -> int:
        n = len(nums)
        dp = [[0] * (k + 1) for _ in range(n)]
        max_dp = [[0] * (k + 1) for _ in range(k + 1)]

        for i in range(n):
            for j in range(k + 1):
                dp[i][j] = 1
                for m in range(j + 1):
                    if nums[i] == nums[i - 1]:
                        dp[i][j] = max(dp[i][j], dp[i - 1][m] + 1)
                    else:
                        dp[i][j] = max(dp[i][j], max_dp[m][j - m] + 1)
                for m in range(j + 1):
                    max_dp[m][j - m] = max(max_dp[m][j - m], dp[i][m])

        result = 0
        for i in range(n):
            for j in range(k + 1):
                result = max(result, dp[i][j])
        return result
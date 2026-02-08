class Solution:
    def maximumLength(self, nums: List[int], k: int) -> int:
        n = len(nums)
        dp = [[0] * (k + 1) for _ in range(n)]
        max_len = [[0] * (k + 1) for _ in range(k + 1)]
        res = 1

        for i in range(n):
            for j in range(k + 1):
                dp[i][j] = 1
                for prev_diff in range(j):
                    if nums[i] == nums[i - 1 - prev_diff]:
                        dp[i][j] = max(dp[i][j], dp[i - 1 - prev_diff][j - prev_diff] + 1)
                res = max(res, dp[i][j])

        return res
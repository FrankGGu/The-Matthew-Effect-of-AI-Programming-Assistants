class Solution:
    def maximumLength(self, nums: List[int], k: int) -> int:
        n = len(nums)
        dp = [[0] * (k + 1) for _ in range(n)]
        max_len = [[0] * (k + 1) for _ in range(k + 1)]
        res = 1

        for i in range(n):
            for j in range(k + 1):
                dp[i][j] = 1
                for m in range(j + 1):
                    if nums[i] == nums[i - 1]:
                        if i > 0:
                            dp[i][j] = max(dp[i][j], dp[i - 1][j] + 1)
                    else:
                        if i > 0 and m <= j:
                            dp[i][j] = max(dp[i][j], max_len[m][j - m] + 1)
                res = max(res, dp[i][j])

            for j in range(k + 1):
                for m in range(k - j + 1):
                    if i == 0:
                        max_len[j][m] = 1
                    else:
                        if nums[i] == nums[i - 1]:
                            max_len[j][m] = max(max_len[j][m], dp[i][j])
                        else:
                            if m + j <= k:
                                max_len[j][m] = max(max_len[j][m], dp[i][j])

        return res
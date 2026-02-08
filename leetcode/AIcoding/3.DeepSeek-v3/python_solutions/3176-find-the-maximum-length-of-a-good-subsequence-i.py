class Solution:
    def maximumLength(self, nums: List[int], k: int) -> int:
        n = len(nums)
        dp = [[0] * (k + 1) for _ in range(n)]
        prev_max = [[0] * (k + 1) for _ in range(n)]

        for i in range(n):
            for j in range(k + 1):
                dp[i][j] = 1
                if j > 0:
                    dp[i][j] = max(dp[i][j], prev_max[i][j - 1] + 1)
                if i > 0:
                    for l in range(i):
                        if nums[l] == nums[i]:
                            dp[i][j] = max(dp[i][j], dp[l][j] + 1)

        for i in range(n):
            for j in range(k + 1):
                if i == 0:
                    prev_max[i][j] = dp[i][j]
                else:
                    prev_max[i][j] = max(prev_max[i - 1][j], dp[i][j])

        max_len = 0
        for i in range(n):
            max_len = max(max_len, dp[i][k])

        return max_len
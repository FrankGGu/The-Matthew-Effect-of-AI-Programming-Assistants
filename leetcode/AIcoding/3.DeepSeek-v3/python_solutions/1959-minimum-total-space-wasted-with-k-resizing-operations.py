class Solution:
    def minSpaceWastedKResizing(self, nums: List[int], k: int) -> int:
        n = len(nums)
        max_table = [[0] * n for _ in range(n)]
        for i in range(n):
            max_val = nums[i]
            total = nums[i]
            for j in range(i + 1, n):
                max_val = max(max_val, nums[j])
                total += nums[j]
                max_table[i][j] = max_val * (j - i + 1) - total

        dp = [[float('inf')] * (k + 2) for _ in range(n)]
        for i in range(n):
            for l in range(1, k + 2):
                if l == 1:
                    dp[i][l] = max_table[0][i]
                else:
                    for j in range(i):
                        dp[i][l] = min(dp[i][l], dp[j][l - 1] + max_table[j + 1][i])

        return dp[n - 1][k + 1]
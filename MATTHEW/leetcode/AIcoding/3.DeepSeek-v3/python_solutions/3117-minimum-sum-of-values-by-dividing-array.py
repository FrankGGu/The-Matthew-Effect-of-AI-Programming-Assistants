class Solution:
    def minimumValueSum(self, nums: List[int], andValues: List[int]) -> int:
        n = len(nums)
        m = len(andValues)
        INF = float('inf')

        dp = [[INF] * (m + 1) for _ in range(n + 1)]
        dp[0][0] = 0

        for i in range(n + 1):
            for j in range(m + 1):
                if dp[i][j] == INF:
                    continue
                if j == m:
                    continue
                current_and = (1 << 30) - 1
                for k in range(i, n):
                    current_and &= nums[k]
                    if current_and < andValues[j]:
                        break
                    if current_and == andValues[j]:
                        if dp[k + 1][j + 1] > dp[i][j] + sum(nums[i:k+1]):
                            dp[k + 1][j + 1] = dp[i][j] + sum(nums[i:k+1])

        return dp[n][m] if dp[n][m] != INF else -1
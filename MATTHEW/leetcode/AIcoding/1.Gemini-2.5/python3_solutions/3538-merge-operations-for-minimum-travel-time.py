class Solution:
    def mergeOperations(self, arr: list[int]) -> int:
        n = len(arr)
        if n <= 1:
            return 0

        dp = [[0] * n for _ in range(n)]

        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i+1] = prefix_sum[i] + arr[i]

        def get_sum(i, j):
            return prefix_sum[j+1] - prefix_sum[i]

        for length in range(2, n + 1):
            for i in range(n - length + 1):
                j = i + length - 1
                dp[i][j] = float('inf')
                for k in range(i, j):
                    dp[i][j] = min(dp[i][j], dp[i][k] + dp[k+1][j] + get_sum(i, j))

        return dp[0][n-1]
class Solution:
    def minimumOperations(self, grid: list[list[int]]) -> int:
        m, n = len(grid), len(grid[0])

        costs = [[0] * 10 for _ in range(n)]
        for j in range(n):
            col_counts = [0] * 10
            for i in range(m):
                col_counts[grid[i][j]] += 1
            for val in range(10):
                costs[j][val] = m - col_counts[val]

        dp = [[float('inf')] * 10 for _ in range(n)]

        for val in range(10):
            dp[0][val] = costs[0][val]

        for j in range(1, n):
            min1_val = float('inf')
            min1_idx = -1
            min2_val = float('inf')

            for val_prev in range(10):
                if dp[j-1][val_prev] < min1_val:
                    min2_val = min1_val
                    min1_val = dp[j-1][val_prev]
                    min1_idx = val_prev
                elif dp[j-1][val_prev] < min2_val:
                    min2_val = dp[j-1][val_prev]

            for curr_val in range(10):
                cost_curr_col = costs[j][curr_val]
                if curr_val != min1_idx:
                    dp[j][curr_val] = cost_curr_col + min1_val
                else:
                    dp[j][curr_val] = cost_curr_col + min2_val

        return min(dp[n-1])
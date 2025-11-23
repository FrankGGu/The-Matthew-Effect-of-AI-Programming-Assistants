class Solution:
    def minimumOperations(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        freq = [[0] * 10 for _ in range(n)]

        for i in range(m):
            for j in range(n):
                freq[j][grid[i][j]] += 1

        dp_prev = [0] * 10
        for j in range(n):
            dp_curr = [float('inf')] * 10
            for k in range(10):
                for prev_k in range(10):
                    if prev_k != k:
                        dp_curr[k] = min(dp_curr[k], dp_prev[prev_k] + (m - freq[j][k]))
            dp_prev = dp_curr

        return min(dp_prev)
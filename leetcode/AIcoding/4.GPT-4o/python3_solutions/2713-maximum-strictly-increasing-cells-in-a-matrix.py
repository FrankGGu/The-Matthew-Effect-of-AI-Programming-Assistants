class Solution:
    def maxIncreasingCells(self, mat: List[List[int]]) -> int:
        from sortedcontainers import SortedList

        n, m = len(mat), len(mat[0])
        dp = [[1] * m for _ in range(n)]
        idx = [(mat[i][j], i, j) for i in range(n) for j in range(m)]
        idx.sort()

        for value, x, y in idx:
            for dx, dy in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                nx, ny = x + dx, y + dy
                if 0 <= nx < n and 0 <= ny < m and mat[nx][ny] < value:
                    dp[x][y] = max(dp[x][y], dp[nx][ny] + 1)

        return max(max(row) for row in dp)
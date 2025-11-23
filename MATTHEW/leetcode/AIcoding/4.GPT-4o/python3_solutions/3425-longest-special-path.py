class Solution:
    def longestSpecialPath(self, grid: List[List[int]]) -> int:
        rows, cols = len(grid), len(grid[0])
        max_length = 0

        def dfs(x, y, length):
            nonlocal max_length
            max_length = max(max_length, length)
            for dx, dy in [(1, 0), (0, 1), (-1, 0), (0, -1)]:
                nx, ny = x + dx, y + dy
                if 0 <= nx < rows and 0 <= ny < cols and grid[nx][ny] == grid[x][y] + 1:
                    dfs(nx, ny, length + 1)

        for i in range(rows):
            for j in range(cols):
                dfs(i, j, 1)

        return max_length
class Solution:
    def minDays(self, grid: List[List[int]]) -> int:
        def count_islands(grid):
            rows, cols = len(grid), len(grid[0])
            visited = set()
            count = 0

            def dfs(i, j):
                if (i, j) in visited or i < 0 or i >= rows or j < 0 or j >= cols or grid[i][j] == 0:
                    return
                visited.add((i, j))
                dfs(i + 1, j)
                dfs(i - 1, j)
                dfs(i, j + 1)
                dfs(i, j - 1)

            for i in range(rows):
                for j in range(cols):
                    if grid[i][j] == 1 and (i, j) not in visited:
                        count += 1
                        dfs(i, j)
            return count

        rows, cols = len(grid), len(grid[0])
        initial_islands = count_islands(grid)

        if initial_islands == 0 or initial_islands > 1:
            return 0

        for i in range(rows):
            for j in range(cols):
                if grid[i][j] == 1:
                    temp = grid[i][j]
                    grid[i][j] = 0
                    if count_islands(grid) != 1:
                        grid[i][j] = temp
                        return 1
                    grid[i][j] = temp

        return 2
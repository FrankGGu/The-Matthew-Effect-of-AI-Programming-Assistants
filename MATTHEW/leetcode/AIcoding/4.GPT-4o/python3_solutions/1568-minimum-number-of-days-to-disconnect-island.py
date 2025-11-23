class Solution:
    def minDays(self, grid: List[List[int]]) -> int:
        def dfs(i, j):
            stack = [(i, j)]
            while stack:
                x, y = stack.pop()
                if 0 <= x < len(grid) and 0 <= y < len(grid[0]) and grid[x][y] == 1:
                    grid[x][y] = -1
                    stack.append((x + 1, y))
                    stack.append((x - 1, y))
                    stack.append((x, y + 1))
                    stack.append((x, y - 1))

        if not grid or not grid[0]:
            return 0

        islands = sum(grid[i][j] == 1 for i in range(len(grid)) for j in range(len(grid[0])))
        if islands == 0:
            return 0
        if islands == 1:
            return 1

        def count_islands():
            count = 0
            for i in range(len(grid)):
                for j in range(len(grid[0])):
                    if grid[i][j] == 1:
                        dfs(i, j)
                        count += 1
            return count

        original_islands = count_islands()
        if original_islands > 1:
            return 0

        return 2
class Solution:
    def uniquePathsIII(self, grid: list[list[int]]) -> int:
        rows, cols = len(grid), len(grid[0])
        start_row, start_col = -1, -1
        empty_cells = 0

        for r in range(rows):
            for c in range(cols):
                if grid[r][c] == 1:
                    start_row, start_col = r, c
                elif grid[r][c] == 0:
                    empty_cells += 1

        def dfs(row, col, visited):
            if row < 0 or row >= rows or col < 0 or col >= cols or grid[row][col] == -1 or (row, col) in visited:
                return 0

            if grid[row][col] == 2:
                if len(visited) == empty_cells + 1:
                    return 1
                else:
                    return 0

            visited.add((row, col))
            count = dfs(row + 1, col, visited) + dfs(row - 1, col, visited) + \
                    dfs(row, col + 1, visited) + dfs(row, col - 1, visited)
            visited.remove((row, col))
            return count

        return dfs(start_row, start_col, set())
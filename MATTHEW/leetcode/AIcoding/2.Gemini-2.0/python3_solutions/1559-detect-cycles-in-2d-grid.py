class Solution:
    def detectCycles(self, grid: List[List[str]]) -> bool:
        rows, cols = len(grid), len(grid[0])
        visited = [[False] * cols for _ in range(rows)]

        def dfs(row, col, parent_row, parent_col, color):
            visited[row][col] = True
            directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

            for dr, dc in directions:
                new_row, new_col = row + dr, col + dc

                if 0 <= new_row < rows and 0 <= new_col < cols and grid[new_row][new_col] == color:
                    if not visited[new_row][new_col]:
                        if dfs(new_row, new_col, row, col, color):
                            return True
                    elif new_row != parent_row or new_col != parent_col:
                        return True

            return False

        for row in range(rows):
            for col in range(cols):
                if not visited[row][col]:
                    if dfs(row, col, -1, -1, grid[row][col]):
                        return True

        return False
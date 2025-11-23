class Solution:
    def colorBorder(self, grid: List[List[int]], row: int, col: int, color: int) -> List[List[int]]:
        m, n = len(grid), len(grid[0])
        visited = set()
        border = []
        initial_color = grid[row][col]

        def dfs(i, j):
            if i < 0 or i >= m or j < 0 or j >= n or grid[i][j] != initial_color or (i, j) in visited:
                return

            visited.add((i, j))

            is_border = i == 0 or i == m - 1 or j == 0 or j == n - 1

            if not is_border:
                neighbors = [(i + 1, j), (i - 1, j), (i, j + 1), (i, j - 1)]
                for ni, nj in neighbors:
                    if ni < 0 or ni >= m or nj < 0 or nj >= n or grid[ni][nj] != initial_color:
                        is_border = True
                        break

            if is_border:
                border.append((i, j))

            dfs(i + 1, j)
            dfs(i - 1, j)
            dfs(i, j + 1)
            dfs(i, j - 1)

        dfs(row, col)

        for i, j in border:
            grid[i][j] = color

        return grid
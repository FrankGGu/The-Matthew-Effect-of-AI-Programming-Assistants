class Solution:
    def canMouseWin(self, grid: List[str], catJump: int, mouseJump: int) -> bool:
        from functools import lru_cache

        rows = len(grid)
        cols = len(grid[0]) if rows else 0

        # Find positions
        for i in range(rows):
            for j in range(cols):
                if grid[i][j] == 'C':
                    cat_pos = (i, j)
                elif grid[i][j] == 'M':
                    mouse_pos = (i, j)
                elif grid[i][j] == 'F':
                    food_pos = (i, j)

        dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        @lru_cache(maxsize=None)
        def dfs(turn, cat_i, cat_j, mouse_i, mouse_j):
            if turn > 100:
                return False
            if (cat_i, cat_j) == (mouse_i, mouse_j):
                return False
            if (cat_i, cat_j) == food_pos:
                return False
            if (mouse_i, mouse_j) == food_pos:
                return True

            if turn % 2 == 0:
                for di, dj in dirs:
                    for step in range(0, mouseJump + 1):
                        ni = mouse_i + di * step
                        nj = mouse_j + dj * step
                        if 0 <= ni < rows and 0 <= nj < cols and grid[ni][nj] != '#':
                            if dfs(turn + 1, cat_i, cat_j, ni, nj):
                                return True
                        else:
                            break
                return False
            else:
                for di, dj in dirs:
                    for step in range(0, catJump + 1):
                        ni = cat_i + di * step
                        nj = cat_j + dj * step
                        if 0 <= ni < rows and 0 <= nj < cols and grid[ni][nj] != '#':
                            if not dfs(turn + 1, ni, nj, mouse_i, mouse_j):
                                return False
                        else:
                            break
                return True

        return dfs(0, cat_pos[0], cat_pos[1], mouse_pos[0], mouse_pos[1])
class Solution:
    def canMouseWin(self, grid: List[str], catJump: int, mouseJump: int) -> bool:
        from functools import lru_cache

        rows, cols = len(grid), len(grid[0])
        dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        # Find positions of cat, mouse, and food
        for i in range(rows):
            for j in range(cols):
                if grid[i][j] == 'C':
                    cat_pos = (i, j)
                elif grid[i][j] == 'M':
                    mouse_pos = (i, j)
                elif grid[i][j] == 'F':
                    food_pos = (i, j)

        @lru_cache(maxsize=None)
        def dfs(turn, cat, mouse):
            if turn >= 100:
                return False
            if cat == mouse:
                return False
            if cat == food_pos:
                return False
            if mouse == food_pos:
                return True

            if turn % 2 == 0:  # mouse's turn
                i, j = mouse
                for di, dj in dirs:
                    for step in range(0, mouseJump + 1):
                        ni, nj = i + di * step, j + dj * step
                        if 0 <= ni < rows and 0 <= nj < cols and grid[ni][nj] != '#':
                            if dfs(turn + 1, cat, (ni, nj)):
                                return True
                        else:
                            break
                return False
            else:  # cat's turn
                i, j = cat
                for di, dj in dirs:
                    for step in range(0, catJump + 1):
                        ni, nj = i + di * step, j + dj * step
                        if 0 <= ni < rows and 0 <= nj < cols and grid[ni][nj] != '#':
                            if not dfs(turn + 1, (ni, nj), mouse):
                                return False
                        else:
                            break
                return True

        return dfs(0, cat_pos, mouse_pos)
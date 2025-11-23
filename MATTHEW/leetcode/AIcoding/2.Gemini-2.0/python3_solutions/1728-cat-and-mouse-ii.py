class Solution:
    def canMouseWin(self, grid: List[str], catJump: int, mouseJump: int) -> bool:
        rows, cols = len(grid), len(grid[0])
        food_x, food_y = -1, -1
        cat_x, cat_y = -1, -1
        mouse_x, mouse_y = -1, -1
        for i in range(rows):
            for j in range(cols):
                if grid[i][j] == 'F':
                    food_x, food_y = i, j
                elif grid[i][j] == 'C':
                    cat_x, cat_y = i, j
                elif grid[i][j] == 'M':
                    mouse_x, mouse_y = i, j

        memo = {}

        def get_neighbors(x, y, jump):
            neighbors = []
            for dx, dy in [(0, 1), (0, -1), (1, 0), (-1, 0)]:
                for k in range(1, jump + 1):
                    nx, ny = x + dx * k, y + dy * k
                    if 0 <= nx < rows and 0 <= ny < cols and grid[nx][ny] != '#':
                        neighbors.append((nx, ny))
                    else:
                        break
            return neighbors

        def can_win(mouse_x, mouse_y, cat_x, cat_y, turns):
            if turns > 1000:
                return False
            if (mouse_x, mouse_y, cat_x, cat_y, turns) in memo:
                return memo[(mouse_x, mouse_y, cat_x, cat_y, turns)]

            if mouse_x == food_x and mouse_y == food_y:
                memo[(mouse_x, mouse_y, cat_x, cat_y, turns)] = True
                return True
            if cat_x == food_x and cat_y == food_y:
                memo[(mouse_x, mouse_y, cat_x, cat_y, turns)] = False
                return False
            if mouse_x == cat_x and mouse_y == cat_y:
                memo[(mouse_x, mouse_y, cat_x, cat_y, turns)] = False
                return False

            if turns % 2 == 0:
                neighbors = get_neighbors(mouse_x, mouse_y, mouseJump)
                if not neighbors:
                    memo[(mouse_x, mouse_y, cat_x, cat_y, turns)] = False
                    return False
                for nx, ny in neighbors:
                    if can_win(nx, ny, cat_x, cat_y, turns + 1):
                        memo[(mouse_x, mouse_y, cat_x, cat_y, turns)] = True
                        return True
                memo[(mouse_x, mouse_y, cat_x, cat_y, turns)] = False
                return False
            else:
                neighbors = get_neighbors(cat_x, cat_y, catJump)
                if not neighbors:
                    memo[(mouse_x, mouse_y, cat_x, cat_y, turns)] = True
                    return True
                for nx, ny in neighbors:
                    if not can_win(mouse_x, mouse_y, nx, ny, turns + 1):
                        memo[(mouse_x, mouse_y, cat_x, cat_y, turns)] = False
                        return False
                memo[(mouse_x, mouse_y, cat_x, cat_y, turns)] = True
                return True

        return can_win(mouse_x, mouse_y, cat_x, cat_y, 0)
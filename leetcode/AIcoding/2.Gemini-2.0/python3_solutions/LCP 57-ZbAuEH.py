class Solution:
    def maxKilledEnemies(self, grid: List[List[str]]) -> int:
        if not grid:
            return 0

        rows = len(grid)
        cols = len(grid[0])
        max_kills = 0

        for i in range(rows):
            for j in range(cols):
                if grid[i][j] == '0':
                    kills = 0

                    # Up
                    r = i - 1
                    while r >= 0:
                        if grid[r][j] == 'E':
                            kills += 1
                        elif grid[r][j] == 'W':
                            break
                        r -= 1

                    # Down
                    r = i + 1
                    while r < rows:
                        if grid[r][j] == 'E':
                            kills += 1
                        elif grid[r][j] == 'W':
                            break
                        r += 1

                    # Left
                    c = j - 1
                    while c >= 0:
                        if grid[i][c] == 'E':
                            kills += 1
                        elif grid[i][c] == 'W':
                            break
                        c -= 1

                    # Right
                    c = j + 1
                    while c < cols:
                        if grid[i][c] == 'E':
                            kills += 1
                        elif grid[i][c] == 'W':
                            break
                        c += 1

                    max_kills = max(max_kills, kills)

        return max_kills
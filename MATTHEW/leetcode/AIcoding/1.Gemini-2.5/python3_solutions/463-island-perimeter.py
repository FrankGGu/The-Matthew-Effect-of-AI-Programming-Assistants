class Solution:
    def islandPerimeter(self, grid: list[list[int]]) -> int:
        rows = len(grid)
        cols = len(grid[0])
        perimeter = 0

        for r in range(rows):
            for c in range(cols):
                if grid[r][c] == 1:
                    perimeter += 4  # Start with 4 sides for each land cell

                    # Check neighbors
                    # Up
                    if r > 0 and grid[r - 1][c] == 1:
                        perimeter -= 1
                    # Down
                    if r < rows - 1 and grid[r + 1][c] == 1:
                        perimeter -= 1
                    # Left
                    if c > 0 and grid[r][c - 1] == 1:
                        perimeter -= 1
                    # Right
                    if c < cols - 1 and grid[r][c + 1] == 1:
                        perimeter -= 1
        return perimeter
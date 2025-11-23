class Solution:
    def checkContiguous(self, grid: list[list[str]]) -> bool:
        for r in range(2):
            for c in range(2):
                color = grid[r][c]
                if (grid[r][c+1] == color and
                    grid[r+1][c] == color and
                    grid[r+1][c+1] == color):
                    return True
        return False
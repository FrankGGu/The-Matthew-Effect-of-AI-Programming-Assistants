class Solution:
    def checkXMatrix(self, grid: list[list[int]]) -> bool:
        n = len(grid)
        for r in range(n):
            for c in range(n):
                is_on_diagonal = (r == c) or (r + c == n - 1)

                if is_on_diagonal:
                    if grid[r][c] == 0:
                        return False
                else:
                    if grid[r][c] != 0:
                        return False

        return True
from collections import defaultdict

class Solution:
    def differenceOfDistinctValues(self, grid: list[list[int]]) -> list[list[int]]:
        m = len(grid)
        n = len(grid[0])

        anti_diagonals = defaultdict(set)
        main_diagonals = defaultdict(set)

        for r in range(m):
            for c in range(n):
                anti_diagonals[r + c].add(grid[r][c])
                main_diagonals[r - c].add(grid[r][c])

        ans = [[0] * n for _ in range(m)]

        for r in range(m):
            for c in range(n):
                d1 = len(anti_diagonals[r + c])
                d2 = len(main_diagonals[r - c])
                ans[r][c] = abs(d1 - d2)

        return ans
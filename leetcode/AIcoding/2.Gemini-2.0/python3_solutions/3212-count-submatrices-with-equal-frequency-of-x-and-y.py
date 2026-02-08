class Solution:
    def countSubmatrices(self, grid: List[List[int]], x: int, y: int) -> int:
        m, n = len(grid), len(grid[0])
        count = 0
        for r1 in range(m):
            for c1 in range(n):
                for r2 in range(r1, m):
                    for c2 in range(c1, n):
                        x_count = 0
                        y_count = 0
                        for i in range(r1, r2 + 1):
                            for j in range(c1, c2 + 1):
                                if grid[i][j] == x:
                                    x_count += 1
                                elif grid[i][j] == y:
                                    y_count += 1
                        if x_count == y_count:
                            count += 1
        return count
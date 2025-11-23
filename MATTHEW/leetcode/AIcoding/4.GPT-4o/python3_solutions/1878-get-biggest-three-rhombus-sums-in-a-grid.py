class Solution:
    def getBiggestThree(self, grid: List[List[int]]) -> List[int]:
        def rhombus_sum(x, y, d):
            total = 0
            for i in range(d + 1):
                total += grid[x + i][y - i] + grid[x + i][y + i]
            for i in range(1, d + 1):
                total += grid[x + d][y - d + i] + grid[x + d][y + d - i]
            return total - grid[x + d][y]

        m, n = len(grid), len(grid[0])
        sums = set()

        for i in range(m):
            for j in range(n):
                for d in range(min(m, n)):
                    if i + d < m and j - d >= 0 and j + d < n:
                        sums.add(rhombus_sum(i, j, d))
                    else:
                        break

        return sorted(sums, reverse=True)[:3]
class Solution:
    def getBiggestThree(self, grid: List[List[int]]) -> List[int]:
        m, n = len(grid), len(grid[0])
        max_sums = set()

        for i in range(m):
            for j in range(n):
                max_sums.add(grid[i][j])
                max_len = min(i, j, m - 1 - i, n - 1 - j)
                for l in range(1, max_len + 1):
                    total = 0
                    x, y = i - l, j
                    for _ in range(l):
                        total += grid[x][y]
                        x += 1
                        y -= 1
                    for _ in range(l):
                        total += grid[x][y]
                        x += 1
                        y += 1
                    for _ in range(l):
                        total += grid[x][y]
                        x -= 1
                        y += 1
                    for _ in range(l):
                        total += grid[x][y]
                        x -= 1
                        y -= 1
                    max_sums.add(total)

        max_sums = sorted(max_sums, reverse=True)
        return max_sums[:3] if len(max_sums) >= 3 else max_sums
class Solution:
    def minFlips(self, grid: List[List[int]]) -> int:
        n = len(grid)
        m = len(grid[0])
        total_flips = 0

        for i in range(n // 2):
            for j in range(m // 2):
                total_flips += self.count_flips(grid, i, j, n, m)

        if n % 2 == 1:
            for j in range(m // 2):
                total_flips += self.count_flips(grid, n // 2, j, n, m)

        if m % 2 == 1:
            for i in range(n // 2):
                total_flips += self.count_flips(grid, i, m // 2, n, m)

        if n % 2 == 1 and m % 2 == 1:
            total_flips += grid[n // 2][m // 2] ^ 1

        return total_flips

    def count_flips(self, grid, i, j, n, m):
        count = grid[i][j] + grid[n - 1 - i][j] + grid[i][m - 1 - j] + grid[n - 1 - i][m - 1 - j]
        return min(count, 4 - count)
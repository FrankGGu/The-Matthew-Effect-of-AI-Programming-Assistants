class Solution:
    def largestMagicSquare(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        dp = [[0] * n for _ in range(m)]
        max_size = 1

        for i in range(m):
            for j in range(n):
                if i == 0 or j == 0:
                    dp[i][j] = 1
                else:
                    if grid[i][j] == grid[i-1][j] == grid[i][j-1] == grid[i-1][j-1]:
                        size = 1
                        while (i - size >= 0 and j - size >= 0 and
                               grid[i][j] == grid[i-size][j] == grid[i][j-size] == grid[i-size][j-size]):
                            valid = True
                            s = grid[i][j]
                            for k in range(size + 1):
                                if sum(grid[i - k][j - l] for l in range(size + 1)) != s * (size + 1):
                                    valid = False
                                    break
                                if sum(grid[i - l][j - k] for l in range(size + 1)) != s * (size + 1):
                                    valid = False
                                    break
                            if not valid:
                                break
                            size += 1
                        dp[i][j] = size
                        max_size = max(max_size, size)

        return max_size
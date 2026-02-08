class Solution:
    def matrixScore(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])

        for i in range(m):
            if grid[i][0] == 0:
                for j in range(n):
                    grid[i][j] ^= 1

        for j in range(1, n):
            count = 0
            for i in range(m):
                if grid[i][j] == 1:
                    count += 1
            if count < m - count:
                for i in range(m):
                    grid[i][j] ^= 1

        score = 0
        for row in grid:
            num = 0
            for bit in row:
                num = (num << 1) | bit
            score += num

        return score
class Solution:
    def countSubmatrices(self, grid: List[List[int]], x: int, y: int) -> int:
        m, n = len(grid), len(grid[0])
        prefix = [[0] * (n + 1) for _ in range(m + 1)]
        count = 0

        for i in range(1, m + 1):
            for j in range(1, n + 1):
                prefix[i][j] = prefix[i-1][j] + prefix[i][j-1] - prefix[i-1][j-1]
                if grid[i-1][j-1] == x:
                    prefix[i][j] += 1
                elif grid[i-1][j-1] == y:
                    prefix[i][j] -= 1

                if prefix[i][j] == 0:
                    count += 1

        return count
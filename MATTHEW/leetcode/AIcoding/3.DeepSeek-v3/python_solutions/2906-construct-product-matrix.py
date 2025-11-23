class Solution:
    def constructProductMatrix(self, grid: List[List[int]]) -> List[List[int]]:
        MOD = 12345
        m, n = len(grid), len(grid[0])
        prefix = [1] * (m * n + 1)
        suffix = [1] * (m * n + 1)

        for i in range(m):
            for j in range(n):
                idx = i * n + j + 1
                prefix[idx] = (prefix[idx - 1] * grid[i][j]) % MOD

        for i in range(m - 1, -1, -1):
            for j in range(n - 1, -1, -1):
                idx = i * n + j
                suffix[idx] = (suffix[idx + 1] * grid[i][j]) % MOD

        res = [[0] * n for _ in range(m)]
        for i in range(m):
            for j in range(n):
                idx = i * n + j
                res[i][j] = (prefix[idx] * suffix[idx + 1]) % MOD

        return res
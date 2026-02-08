class Solution:
    def countPaths(self, grid: list[list[int]]) -> int:
        R = len(grid)
        C = len(grid[0])
        MOD = 10**9 + 7

        memo = [[-1 for _ in range(C)] for _ in range(R)]

        dirs = [(0, 1), (0, -1), (1, 0), (-1, 0)]

        def dfs(r, c):
            if memo[r][c] != -1:
                return memo[r][c]

            count = 1

            for dr, dc in dirs:
                nr, nc = r + dr, c + dc

                if 0 <= nr < R and 0 <= nc < C and grid[nr][nc] > grid[r][c]:
                    count = (count + dfs(nr, nc)) % MOD

            memo[r][c] = count
            return count

        total_paths = 0
        for r in range(R):
            for c in range(C):
                total_paths = (total_paths + dfs(r, c)) % MOD

        return total_paths
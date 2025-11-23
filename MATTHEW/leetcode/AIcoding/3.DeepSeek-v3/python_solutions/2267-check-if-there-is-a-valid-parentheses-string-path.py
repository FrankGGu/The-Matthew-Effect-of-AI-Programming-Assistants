class Solution:
    def hasValidPath(self, grid: List[List[str]]) -> bool:
        m, n = len(grid), len(grid[0])
        if (m + n - 1) % 2 != 0:
            return False

        max_possible = (m + n - 1) // 2
        memo = [[[-1] * (max_possible + 1) for _ in range(n)] for __ in range(m)]

        def dfs(i, j, balance):
            if i >= m or j >= n:
                return False
            current = 1 if grid[i][j] == '(' else -1
            balance += current
            if balance < 0 or balance > max_possible:
                return False
            if i == m - 1 and j == n - 1:
                return balance == 0
            if memo[i][j][balance] != -1:
                return memo[i][j][balance] == 1
            res = dfs(i + 1, j, balance) or dfs(i, j + 1, balance)
            memo[i][j][balance] = 1 if res else 0
            return res

        return dfs(0, 0, 0)
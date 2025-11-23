class Solution:
    def hasValidPath(self, grid: List[List[str]]) -> bool:
        m, n = len(grid), len(grid[0])
        if (m + n - 1) % 2 != 0:
            return False

        @lru_cache(None)
        def dfs(row, col, balance):
            if row == m or col == n or balance < 0:
                return False

            if grid[row][col] == '(':
                balance += 1
            else:
                balance -= 1

            if row == m - 1 and col == n - 1:
                return balance == 0

            return dfs(row + 1, col, balance) or dfs(row, col + 1, balance)

        return dfs(0, 0, 0)
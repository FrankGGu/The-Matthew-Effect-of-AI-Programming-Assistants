class Solution:
    def fillGrid(self, grid: List[List[int]]) -> List[List[int]]:
        m, n = len(grid), len(grid[0])
        rows = [set() for _ in range(m)]
        cols = [set() for _ in range(n)]

        for i in range(m):
            for j in range(n):
                if grid[i][j] != 0:
                    rows[i].add(grid[i][j])
                    cols[j].add(grid[i][j])

        def backtrack(i, j):
            if i == m:
                return True
            if j == n:
                return backtrack(i + 1, 0)
            if grid[i][j] != 0:
                return backtrack(i, j + 1)

            for num in range(1, m + n + 1):
                if num not in rows[i] and num not in cols[j]:
                    grid[i][j] = num
                    rows[i].add(num)
                    cols[j].add(num)

                    if backtrack(i, j + 1):
                        return True

                    grid[i][j] = 0
                    rows[i].remove(num)
                    cols[j].remove(num)
            return False

        backtrack(0, 0)
        return grid
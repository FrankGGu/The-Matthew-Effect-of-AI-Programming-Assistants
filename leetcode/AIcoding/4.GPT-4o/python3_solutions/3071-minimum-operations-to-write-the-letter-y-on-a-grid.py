class Solution:
    def minimumOperations(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        operations = float('inf')

        for i in range(m):
            for j in range(n):
                if grid[i][j] == 1:
                    cnt = 0
                    for x in range(m):
                        for y in range(n):
                            if (x == i and y == j) or (x + y == i + j) or (x - y == i - j):
                                if grid[x][y] == 0:
                                    cnt += 1
                    operations = min(operations, cnt)

        return operations if operations != float('inf') else -1
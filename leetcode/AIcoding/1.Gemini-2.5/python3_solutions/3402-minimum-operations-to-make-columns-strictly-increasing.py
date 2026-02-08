from typing import List

class Solution:
    def minOperations(self, grid: List[List[int]]) -> int:
        m = len(grid)
        if m == 0:
            return 0
        n = len(grid[0])
        if n == 0:
            return 0

        operations = 0
        for j in range(n):
            for i in range(1, m):
                if grid[i][j] < grid[i-1][j]:
                    operations += 1
                    break
        return operations
class Solution:
    def maxValueSum(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        max_sum = 0

        for i1 in range(m):
            for j1 in range(n):
                for i2 in range(m):
                    for j2 in range(n):
                        for i3 in range(m):
                            for j3 in range(n):
                                if (i1 != i2 or j1 != j2) and (i1 != i3 or j1 != j3) and (i2 != i3 or j2 != j3):
                                    total = grid[i1][j1] + grid[i2][j2] + grid[i3][j3]
                                    if total > max_sum:
                                        max_sum = total
        return max_sum
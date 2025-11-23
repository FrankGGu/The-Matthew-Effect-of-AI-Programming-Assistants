class Solution:
    def pivotGrid(self, grid: List[List[int]], pivot: List[int]) -> List[List[int]]:
        r, c = len(grid), len(grid[0])
        pivot_row, pivot_col = pivot

        result = [[0] * c for _ in range(r)]

        for i in range(r):
            for j in range(c):
                new_row = (i + pivot_row) % r
                new_col = (j + pivot_col) % c
                result[new_row][new_col] += grid[i][j]

        return result
class Solution:
    def deleteGreatestValue(self, grid: List[List[int]]) -> int:
        for row in grid:
            row.sort()
        res = 0
        for j in range(len(grid[0])):
            max_val = 0
            for i in range(len(grid)):
                max_val = max(max_val, grid[i][j])
            res += max_val
        return res
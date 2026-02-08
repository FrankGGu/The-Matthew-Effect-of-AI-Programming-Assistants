class Solution:
    def deleteGreatestValue(self, grid: List[List[int]]) -> int:
        for row in grid:
            row.sort()

        total_sum = 0
        for j in range(len(grid[0])):
            max_val = 0
            for i in range(len(grid)):
                max_val = max(max_val, grid[i][j])
            total_sum += max_val

        return total_sum
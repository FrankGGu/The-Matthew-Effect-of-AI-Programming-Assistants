class Solution:
    def findBall(self, grid: List[List[int]]) -> List[int]:
        m, n = len(grid), len(grid[0])
        res = []
        for col in range(n):
            current_col = col
            for row in range(m):
                next_col = current_col + grid[row][current_col]
                if next_col < 0 or next_col >= n or grid[row][current_col] != grid[row][next_col]:
                    current_col = -1
                    break
                current_col = next_col
            res.append(current_col)
        return res
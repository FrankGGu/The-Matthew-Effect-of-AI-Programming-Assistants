class Solution:
    def canPartition(self, grid: List[List[int]]) -> bool:
        total_sum = sum(sum(row) for row in grid)
        if total_sum % 2 != 0:
            return False
        target = total_sum // 2
        n, m = len(grid), len(grid[0])

        def dfs(x, y, current_sum):
            if current_sum == target:
                return True
            if current_sum > target or x >= n or y >= m:
                return False

            next_x, next_y = (x, y + 1) if y + 1 < m else (x + 1, 0)
            return (dfs(next_x, next_y, current_sum + grid[x][y]) or 
                    dfs(next_x, next_y, current_sum))

        return dfs(0, 0, 0)
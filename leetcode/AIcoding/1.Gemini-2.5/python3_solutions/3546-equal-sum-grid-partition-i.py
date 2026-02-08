class Solution:
    def equalSumGridPartition(self, grid: list[list[int]]) -> bool:
        m = len(grid)
        n = len(grid[0])

        total_sum = 0
        for r in range(m):
            for c in range(n):
                total_sum += grid[r][c]

        if total_sum % 2 != 0:
            return False

        target_sum = total_sum // 2

        current_partial_sum = 0
        for r in range(m - 1):
            for c in range(n):
                current_partial_sum += grid[r][c]
            if current_partial_sum == target_sum:
                return True

        current_partial_sum = 0
        for c in range(n - 1):
            for r in range(m):
                current_partial_sum += grid[r][c]
            if current_partial_sum == target_sum:
                return True

        return False
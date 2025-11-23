class Solution:
    def canPartition(self, grid: List[List[int]]) -> bool:
        total_sum = sum(sum(row) for row in grid)
        if total_sum % 2 != 0:
            return False
        target = total_sum // 2
        n, m = len(grid), len(grid[0])

        dp = set()
        dp.add(0)

        for i in range(n):
            for j in range(m):
                for curr_sum in list(dp):
                    new_sum = curr_sum + grid[i][j]
                    if new_sum == target:
                        return True
                    if new_sum < target:
                        dp.add(new_sum)

        return False
class Solution:
    def possibleToStamp(self, grid: List[List[int]], stampHeight: int, stampWidth: int) -> bool:
        m, n = len(grid), len(grid[0])
        prefix_sum = [[0] * (n + 1) for _ in range(m + 1)]
        for i in range(1, m + 1):
            for j in range(1, n + 1):
                prefix_sum[i][j] = prefix_sum[i - 1][j] + prefix_sum[i][j - 1] - prefix_sum[i - 1][j - 1] + grid[i - 1][j - 1]

        stampable = [[0] * n for _ in range(m)]
        for i in range(m - stampHeight + 1):
            for j in range(n - stampWidth + 1):
                area_sum = prefix_sum[i + stampHeight][j + stampWidth] - prefix_sum[i][j + stampWidth] - prefix_sum[i + stampHeight][j] + prefix_sum[i][j]
                if area_sum == 0:
                    stampable[i][j] = 1

        diff = [[0] * (n + 1) for _ in range(m + 1)]
        for i in range(m):
            for j in range(n):
                if stampable[i][j] == 1:
                    diff[i + 1][j + 1] += 1
                    if i + stampHeight < m:
                        diff[i + stampHeight + 1][j + 1] -= 1
                    if j + stampWidth < n:
                        diff[i + 1][j + stampWidth + 1] -= 1
                    if i + stampHeight < m and j + stampWidth < n:
                        diff[i + stampHeight + 1][j + stampWidth + 1] += 1

        covered = [[0] * n for _ in range(m)]
        for i in range(1, m + 1):
            for j in range(1, n + 1):
                covered[i - 1][j - 1] = covered[i - 1][j - 1] + diff[i][j] + (covered[i - 2][j - 1] if i > 1 else 0) + (covered[i - 1][j - 2] if j > 1 else 0) - (covered[i - 2][j - 2] if i > 1 and j > 1 else 0)

        for i in range(m):
            for j in range(n):
                if grid[i][j] == 0 and covered[i][j] == 0:
                    return False

        return True
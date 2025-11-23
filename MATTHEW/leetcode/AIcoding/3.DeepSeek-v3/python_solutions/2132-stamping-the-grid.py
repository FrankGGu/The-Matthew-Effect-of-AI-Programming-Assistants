class Solution:
    def possibleToStamp(self, grid: List[List[int]], stampHeight: int, stampWidth: int) -> bool:
        m, n = len(grid), len(grid[0])
        prefix = [[0] * (n + 1) for _ in range(m + 1)]
        diff = [[0] * (n + 1) for _ in range(m + 1)]

        for i in range(m):
            row_sum = 0
            for j in range(n):
                row_sum += grid[i][j]
                prefix[i + 1][j + 1] = prefix[i][j + 1] + row_sum

        for i in range(m - stampHeight + 1):
            for j in range(n - stampWidth + 1):
                x1, y1 = i, j
                x2, y2 = i + stampHeight - 1, j + stampWidth - 1
                total = prefix[x2 + 1][y2 + 1] - prefix[x1][y2 + 1] - prefix[x2 + 1][y1] + prefix[x1][y1]
                if total == 0:
                    diff[x1][y1] += 1
                    diff[x1][y2 + 1] -= 1
                    diff[x2 + 1][y1] -= 1
                    diff[x2 + 1][y2 + 1] += 1

        stamp = [[0] * (n + 1) for _ in range(m + 1)]
        for i in range(m):
            row_sum = 0
            for j in range(n):
                row_sum += diff[i][j]
                stamp[i + 1][j + 1] = stamp[i][j + 1] + row_sum

        for i in range(m):
            for j in range(n):
                if grid[i][j] == 0 and stamp[i + 1][j + 1] == 0:
                    return False
        return True
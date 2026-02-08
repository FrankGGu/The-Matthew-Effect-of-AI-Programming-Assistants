class Solution:
    def possibleToStamp(self, grid: List[List[int]], stampHeight: int, stampWidth: int) -> bool:
        m, n = len(grid), len(grid[0])
        prefix = [[0] * (n + 1) for _ in range(m + 1)]
        diff = [[0] * (n + 1) for _ in range(m + 1)]

        for i in range(m):
            for j in range(n):
                prefix[i + 1][j + 1] = prefix[i][j + 1] + prefix[i + 1][j] - prefix[i][j] + grid[i][j]

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

        for i in range(m):
            for j in range(n):
                if i > 0:
                    diff[i][j] += diff[i - 1][j]
                if j > 0:
                    diff[i][j] += diff[i][j - 1]
                if i > 0 and j > 0:
                    diff[i][j] -= diff[i - 1][j - 1]
                if grid[i][j] == 0 and diff[i][j] == 0:
                    return False
        return True
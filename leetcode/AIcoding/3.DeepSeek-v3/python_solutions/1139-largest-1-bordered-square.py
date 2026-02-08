class Solution:
    def largest1BorderedSquare(self, grid: List[List[int]]) -> int:
        if not grid or not grid[0]:
            return 0
        m, n = len(grid), len(grid[0])
        left = [[0] * n for _ in range(m)]
        top = [[0] * n for _ in range(m)]

        for i in range(m):
            for j in range(n):
                if grid[i][j] == 1:
                    left[i][j] = 1 if j == 0 else left[i][j-1] + 1
                    top[i][j] = 1 if i == 0 else top[i-1][j] + 1

        max_len = 0
        for i in range(m):
            for j in range(n):
                min_len = min(left[i][j], top[i][j])
                while min_len > max_len:
                    if left[i - min_len + 1][j] >= min_len and top[i][j - min_len + 1] >= min_len:
                        max_len = min_len
                        break
                    min_len -= 1
        return max_len * max_len
class Solution:
    def isPrintable(self, grid: List[List[int]]) -> bool:
        m, n = len(grid), len(grid[0])
        color_rect = {}

        for i in range(m):
            for j in range(n):
                c = grid[i][j]
                if c not in color_rect:
                    color_rect[c] = [i, j, i, j]
                else:
                    color_rect[c][0] = min(color_rect[c][0], i)
                    color_rect[c][1] = min(color_rect[c][1], j)
                    color_rect[c][2] = max(color_rect[c][2], i)
                    color_rect[c][3] = max(color_rect[c][3], j)

        for c in color_rect:
            r1, c1, r2, c2 = color_rect[c]
            for i in range(r1, r2 + 1):
                for j in range(c1, c2 + 1):
                    if grid[i][j] != c:
                        return False
        return True
class Solution:
    def isPrintable(self, grid: list[list[int]], stampHeight: int, stampWidth: int) -> bool:
        m, n = len(grid), len(grid[0])

        prefix_sum_grid = [[0] * (n + 1) for _ in range(m + 1)]
        for r in range(m):
            for c in range(n):
                prefix_sum_grid[r + 1][c + 1] = grid[r][c] + \
                                                prefix_sum_grid[r][c + 1] + \
                                                prefix_sum_grid[r + 1][c] - \
                                                prefix_sum_grid[r][c]

        def get_rect_sum(r1, c1, r2, c2):
            return prefix_sum_grid[r2 + 1][c2 + 1] - \
                   prefix_sum_grid[r1][c2 + 1] - \
                   prefix_sum_grid[r2 + 1][c1] + \
                   prefix_sum_grid[r1][c1]

        stamp_coverage_diff = [[0] * (n + 1) for _ in range(m + 1)]

        for r in range(m - stampHeight + 1):
            for c in range(n - stampWidth + 1):
                if get_rect_sum(r, c, r + stampHeight - 1, c + stampWidth - 1) == 0:
                    stamp_coverage_diff[r][c] += 1
                    if c + stampWidth <= n:
                        stamp_coverage_diff[r][c + stampWidth] -= 1
                    if r + stampHeight <= m:
                        stamp_coverage_diff[r + stampHeight][c] -= 1
                    if r + stampHeight <= m and c + stampWidth <= n:
                        stamp_coverage_diff[r + stampHeight][c + stampWidth] += 1

        for r in range(m + 1):
            for c in range(n + 1):
                if r > 0:
                    stamp_coverage_diff[r][c] += stamp_coverage_diff[r - 1][c]
                if c > 0:
                    stamp_coverage_diff[r][c] += stamp_coverage_diff[r][c - 1]
                if r > 0 and c > 0:
                    stamp_coverage_diff[r][c] -= stamp_coverage_diff[r - 0][c - 0] # This line is actually stamp_coverage_diff[r-1][c-1]

        for r in range(m + 1):
            for c in range(n + 1):
                if r > 0:
                    stamp_coverage_diff[r][c] += stamp_coverage_diff[r - 1][c]
                if c > 0:
                    stamp_coverage_diff[r][c] += stamp_coverage_diff[r][c - 1]
                if r > 0 and c > 0:
                    stamp_coverage_diff[r][c] -= stamp_coverage_diff[r - 1][c - 1]

        for r in range(m):
            for c in range(n):
                if grid[r][c] == 0:
                    if stamp_coverage_diff[r][c] == 0:
                        return False

        return True
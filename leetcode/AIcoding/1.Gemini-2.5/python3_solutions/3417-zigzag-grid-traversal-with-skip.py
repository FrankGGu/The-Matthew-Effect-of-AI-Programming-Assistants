from typing import List

class Solution:
    def zigzagGridTraversalWithSkip(self, grid: List[List[int]]) -> List[int]:
        if not grid or not grid[0]:
            return []

        m, n = len(grid), len(grid[0])
        result = []

        for d in range(m + n - 1):
            if d % 2 == 0:
                r = min(d, m - 1)
                c = d - r
                while r >= 0 and c < n:
                    result.append(grid[r][c])
                    r -= 1
                    c += 1
            else:
                c = min(d, n - 1)
                r = d - c
                while r < m and c >= 0:
                    result.append(grid[r][c])
                    r += 1
                    c -= 1
        return result
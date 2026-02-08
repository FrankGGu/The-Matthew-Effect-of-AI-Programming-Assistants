from typing import List

class Solution:
    def canCut(self, grid: List[List[int]]) -> bool:
        R = len(grid)
        C = len(grid[0])

        def is_monochromatic(r1: int, c1: int, r2: int, c2: int) -> bool:
            if r1 > r2 or c1 > c2:
                return False

            val = grid[r1][c1]
            for r in range(r1, r2 + 1):
                for c in range(c1, c2 + 1):
                    if grid[r][c] != val:
                        return False
            return True

        for r_cut_idx in range(R - 1):
            if is_monochromatic(0, 0, r_cut_idx, C - 1) and \
               is_monochromatic(r_cut_idx + 1, 0, R - 1, C - 1):
                return True

        for c_cut_idx in range(C - 1):
            if is_monochromatic(0, 0, R - 1, c_cut_idx) and \
               is_monochromatic(0, c_cut_idx + 1, R - 1, C - 1):
                return True

        return False
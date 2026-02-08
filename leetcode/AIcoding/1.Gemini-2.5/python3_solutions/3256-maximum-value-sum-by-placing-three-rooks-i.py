import math

class Solution:
    def solve(self, grid: list[list[int]]) -> int:
        R = len(grid)
        C = len(grid[0])

        if R < 3 or C < 3:
            return -math.inf

        max_overall_sum = -math.inf

        M1_prefix = [[-math.inf] * C for _ in range(R)]
        for c_idx in range(C):
            current_max_val = -math.inf
            for r_idx in range(R):
                M1_prefix[r_idx][c_idx] = current_max_val
                current_max_val = max(current_max_val, grid[r_idx][c_idx])

        M2_suffix = [[-math.inf] * C for _ in range(R)]
        for c_idx in range(C):
            current_max_val = -math.inf
            for r_idx in range(R - 1, -1, -1):
                M2_suffix[r_idx][c_idx] = current_max_val
                current_max_val = max(current_max_val, grid[r_idx][c_idx])

        for r2 in range(1, R - 1):
            for c2 in range(C):
                current_rook2_val = grid[r2][c2]

                max1_val_M1 = -math.inf
                max1_idx_M1 = -1
                max2_val_M1 = -math.inf
                max2_idx_M1 = -1

                for c_idx_M1 in range(C):
                    if c_idx_M1 == c2:
                        continue
                    val = M1_prefix[r2][c_idx_M1]
                    if val > max1_val_M1:
                        max2_val_M1 = max1_val_M1
                        max2_idx_M1 = max1_idx_M1
                        max1_val_M1 = val
                        max1_idx_M1 = c_idx_M1
                    elif val > max2_val_M1:
                        max2_val_M1 = val
                        max2_idx_M1 = c_idx_M1

                max1_val_M2 = -math.inf
                max1_idx_M2 = -1
                max2_val_M2 = -math.inf
                max2_idx_M2 = -1

                for c_idx_M2 in range(C):
                    if c_idx_M2 == c2:
                        continue
                    val = M2_suffix[r2][c_idx_M2]
                    if val > max1_val_M2:
                        max2_val_M2 = max1_val_M2
                        max2_idx_M2 = max1_idx_M2
                        max1_val_M2 = val
                        max1_idx_M2 = c_idx_M2
                    elif val > max2_val_M2:
                        max2_val_M2 = val
                        max2_idx_M2 = c_idx_M2

                m1_candidates = []
                if max1_val_M1 != -math.inf: m1_candidates.append((max1_val_M1, max1_idx_M1))
                if max2_val_M1 != -math.inf: m1_candidates.append((max2_val_M1, max2_idx_M1))

                m2_candidates = []
                if max1_val_M2 != -math.inf: m2_candidates.append((max1_val_M2, max1_idx_M2))
                if max2_val_M2 != -math.inf: m2_candidates.append((max2_val_M2, max2_idx_M2))

                for val1, idx1 in m1_candidates:
                    for val3, idx3 in m2_candidates:
                        if idx1 != idx3:
                            current_total_sum = current_rook2_val + val1 + val3
                            max_overall_sum = max(max_overall_sum, current_total_sum)

        return max_overall_sum
from typing import List

class Solution:
    def getBiggestThree(self, grid: List[List[int]]) -> List[int]:
        m, n = len(grid), len(grid[0])

        # dp_ul[r][c] stores the prefix sum of elements on the diagonal
        # where i - j = r - c, from the top-leftmost point on that diagonal
        # to (r, c).
        dp_ul = [[0] * n for _ in range(m)]

        # dp_ur[r][c] stores the prefix sum of elements on the diagonal
        # where i + j = r + c, from the top-rightmost point on that diagonal
        # to (r, c).
        dp_ur = [[0] * n for _ in range(m)]

        for r in range(m):
            for c in range(n):
                dp_ul[r][c] = grid[r][c]
                if r > 0 and c > 0:
                    dp_ul[r][c] += dp_ul[r-1][c-1]

        for r in range(m):
            for c in range(n):
                dp_ur[r][c] = grid[r][c]
                if r > 0 and c < n - 1:
                    dp_ur[r][c] += dp_ur[r-1][c+1]

        rhombus_sums = set()

        # Helper to get dp_ul value, handling out-of-bounds as 0
        def get_ul_prefix_sum(r, c):
            if r < 0 or c < 0:
                return 0
            return dp_ul[r][c]

        # Helper to get dp_ur value, handling out-of-bounds as 0
        def get_ur_prefix_sum(r, c):
            if r < 0 or c >= n:
                return 0
            return dp_ur[r][c]

        # Helper to calculate sum of a diagonal segment (top-left to bottom-right direction)
        # from (r1, c1) to (r2, c2) inclusive, where r1 <= r2, c1 <= c2, and r1-c1 == r2-c2.
        def get_diag_ul_sum(r1, c1, r2, c2):
            res = get_ul_prefix_sum(r2, c2)
            res -= get_ul_prefix_sum(r1-1, c1-1)
            return res

        # Helper to calculate sum of a diagonal segment (top-right to bottom-left direction)
        # from (r1, c1) to (r2, c2) inclusive, where r1 <= r2, c1 >= c2, and r1+c1 == r2+c2.
        def get_diag_ur_sum(r1, c1, r2, c2):
            res = get_ur_prefix_sum(r2, c2)
            res -= get_ur_prefix_sum(r1-1, c1+1)
            return res

        for r in range(m):
            for c in range(n):
                # Rhombus of size s=0 (single cell)
                rhombus_sums.add(grid[r][c])

                # Iterate through possible rhombus sizes s > 0
                # A rhombus of size s centered at (r, c) must have its corners within bounds.
                # Top: (r-s, c), Bottom: (r+s, c), Left: (r, c-s), Right: (r, c+s)
                # So, r-s >= 0, r+s < m, c-s >= 0, c+s < n
                # This implies s <= r, s <= m-1-r, s <= c, s <= n-1-c
                max_s = min(r, m - 1 - r, c, n - 1 - c)

                for s in range(1, max_s + 1):
                    # Define the four corner points of the rhombus
                    p1_r, p1_c = r - s, c     # Top point
                    p2_r, p2_c = r, c + s     # Right point
                    p3_r, p3_c = r + s, c     # Bottom point
                    p4_r, p4_c = r, c - s     # Left point

                    current_sum = 0
                    # Sum of segment P1 to P2 (top-right side)
                    current_sum += get_diag_ul_sum(p1_r, p1_c, p2_r, p2_c)
                    # Sum of segment P2 to P3 (bottom-right side)
                    current_sum += get_diag_ur_sum(p2_r, p2_c, p3_r, p3_c)
                    # Sum of segment P4 to P3 (bottom-left side)
                    current_sum += get_diag_ul_sum(p4_r, p4_c, p3_r, p3_c)
                    # Sum of segment P1 to P4 (top-left side)
                    current_sum += get_diag_ur_sum(p1_r, p1_c, p4_r, p4_c)

                    # The four corner points (P1, P2, P3, P4) are included in two segments each.
                    # We need to subtract them once to count each point exactly once.
                    current_sum -= grid[p1_r][p1_c]
                    current_sum -= grid[p2_r][p2_c]
                    current_sum -= grid[p3_r][p3_c]
                    current_sum -= grid[p4_r][p4_c]

                    rhombus_sums.add(current_sum)

        # Convert set to list, sort in descending order, and take the top 3 (or fewer if not available)
        result = sorted(list(rhombus_sums), reverse=True)
        return result[:min(3, len(result))]
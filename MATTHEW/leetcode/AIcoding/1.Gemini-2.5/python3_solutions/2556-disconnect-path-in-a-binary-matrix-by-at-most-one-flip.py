class Solution:
    def isPossibleToCutPath(self, grid: list[list[int]]) -> bool:
        m, n = len(grid), len(grid[0])

        # Edge case: 1x1 grid. Start and end are the same cell.
        # There are no intermediate cells to flip. So, it's not possible to disconnect.
        if m == 1 and n == 1:
            return False

        # dp_start[r][c] will be True if (r,c) is reachable from (0,0)
        dp_start = [[False] * n for _ in range(m)]
        if grid[0][0] == 1:
            dp_start[0][0] = True

        for r in range(m):
            for c in range(n):
                if grid[r][c] == 1:
                    if r > 0 and dp_start[r-1][c]:
                        dp_start[r][c] = True
                    if c > 0 and dp_start[r][c-1]:
                        dp_start[r][c] = True

        # If (m-1, n-1) is not reachable from (0,0) initially, it's already disconnected.
        # So, it's possible to "disconnect" with zero flips.
        if not dp_start[m-1][n-1]:
            return True

        # dp_end[r][c] will be True if (m-1,n-1) is reachable from (r,c)
        dp_end = [[False] * n for _ in range(m)]
        if grid[m-1][n-1] == 1:
            dp_end[m-1][n-1] = True

        for r in range(m - 1, -1, -1):
            for c in range(n - 1, -1, -1):
                if grid[r][c] == 1:
                    if r < m - 1 and dp_end[r+1][c]:
                        dp_end[r][c] = True
                    if c < n - 1 and dp_end[r][c+1]:
                        dp_end[r][c] = True

        # Iterate through diagonals (sum of r+c) from 1 to m+n-3.
        # These represent intermediate "layers" of cells a path must cross.
        # k = r + c
        # k=0 is (0,0)
        # k=m+n-2 is (m-1,n-1)
        # We are interested in intermediate cells, so k from 1 to m+n-3
        for k in range(1, m + n - 2):
            count_active_cells_on_diagonal = 0
            # Iterate through cells (r,c) on the current diagonal
            for r in range(m):
                c = k - r
                if 0 <= c < n: # Check if (r,c) is within grid boundaries
                    # An "active" cell is part of some path from (0,0) to (m-1,n-1)
                    # and is not the start or end cell.
                    if grid[r][c] == 1 and dp_start[r][c] and dp_end[r][c]:
                        # Exclude start and end cells from being counted as potential cut points
                        if not (r == 0 and c == 0) and not (r == m - 1 and c == n - 1):
                            count_active_cells_on_diagonal += 1

            # If any intermediate diagonal has only one active cell,
            # that cell is an articulation point (cut vertex).
            # Flipping it disconnects all paths.
            if count_active_cells_on_diagonal == 1:
                return True

        # If no such articulation point was found on any intermediate diagonal,
        # it means for every intermediate diagonal, there are at least two active cells.
        # This implies there are at least two node-disjoint paths (excluding start/end),
        # so one flip is not enough to disconnect all paths.
        return False
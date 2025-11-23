class Solution {
    int m, n;
    int[][] grid;

    // This DFS finds *a* path from (r,c) to (m-1, n-1) and marks its cells in pathCells.
    // It uses backtracking to ensure pathCells only contains cells of a single valid path.
    public boolean dfsPath(int r, int c, boolean[][] pathCells) {
        // Base cases: out of bounds, cell is 0, or already visited in current path attempt
        if (r < 0 || r >= m || c < 0 || c >= n || grid[r][c] == 0 || pathCells[r][c]) {
            return false;
        }

        // If destination reached, mark it as part of the path and return true
        if (r == m - 1 && c == n - 1) {
            pathCells[r][c] = true;
            return true;
        }

        pathCells[r][c] = true; // Tentatively mark current cell as part of the path

        // Explore right and down
        if (dfsPath(r + 1, c, pathCells) || dfsPath(r, c + 1, pathCells)) {
            return true; // Path found
        }

        pathCells[r][c] = false; // Backtrack: this cell does not lead to the destination
        return false;
    }

    // This DFS searches for a second path from (r,c) to (m-1, n-1).
    // It avoids cells that were part of the first path (path1Cells), except for the start and end points.
    public boolean dfsSecondPath(int r, int c, boolean[][] path1Cells, boolean[][] visited2) {
        // Base cases: out of bounds, cell is 0, or already visited in this second path search
        if (r < 0 || r >= m || c < 0 || c >= n || grid[r][c] == 0 || visited2[r][c]) {
            return false;
        }

        // If current cell is part of path1Cells AND it's not an endpoint ((0,0) or (m-1,n-1)),
        // then this cell is blocked for the second path.
        if (path1Cells[r][c] && !((r == 0 && c == 0) || (r == m - 1 && c == n - 1))) {
            return false;
        }

        // Destination reached
        if (r == m - 1 && c == n - 1) {
            return true;
        }

        visited2[r][c] = true; // Mark current cell as visited for this second path search

        // Explore right and down
        if (dfsSecondPath(r + 1, c, path1Cells, visited2) || dfsSecondPath(r, c + 1, path1Cells, visited2)) {
            return true; // Path found
        }

        // No need to unmark visited2[r][c] because we are only checking reachability, not reconstructing a path.
        return false;
    }

    public boolean isPossibleToCutPath(int[][] grid) {
        this.grid = grid;
        m = grid.length;
        n = grid[0].length;

        // If the start or end cell is 0, no path can exist.
        // It's already disconnected, so return true.
        if (grid[0][0] == 0 || grid[m - 1][n - 1] == 0) {
            return true;
        }

        // Step 1: Find one path from (0,0) to (m-1, n-1) and mark its cells in path1Cells.
        boolean[][] path1Cells = new boolean[m][n];
        if (!dfsPath(0, 0, path1Cells)) {
            // If no path exists at all, it's already disconnected.
            return true;
        }

        // Step 2: Try to find a second path that is vertex-disjoint from the first path
        // (except possibly at the start and end points).
        boolean[][] visited2 = new boolean[m][n]; // To track visited cells for the second DFS
        if (dfsSecondPath(0, 0, path1Cells, visited2)) {
            // If a second disjoint path exists, it means there are at least two ways
            // to reach the destination. We cannot disconnect all paths with just one flip.
            return false;
        } else {
            // If no second disjoint path exists, it implies that all paths must share
            // at least one common cell (other than (0,0) and (m-1,n-1)).
            // We can flip one such common cell to disconnect all paths.
            return true;
        }
    }
}
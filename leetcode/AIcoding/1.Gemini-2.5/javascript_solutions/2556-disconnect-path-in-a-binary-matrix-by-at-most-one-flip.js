var isPossibleToDisconnectPath = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    // Helper function to check if a path exists from (startR, startC) to (endR, endC)
    // using only '1' cells and moving right or down.
    function checkPath(startR, startC, endR, endC, currentGrid) {
        // If start or end cell is 0 in the current grid, no path can exist through them.
        // This check is crucial because the grid might be modified.
        if (currentGrid[startR][startC] === 0 || currentGrid[endR][endC] === 0) {
            return false;
        }

        const pathVisited = new Array(m).fill(0).map(() => new Array(n).fill(false));
        const queue = [[startR, startC]];
        pathVisited[startR][startC] = true;

        while (queue.length > 0) {
            const [r, c] = queue.shift();

            // If we reached the target, a path exists
            if (r === endR && c === endC) {
                return true;
            }

            // Possible moves: right (0, 1) and down (1, 0)
            const dr = [0, 1];
            const dc = [1, 0];

            for (let i = 0; i < 2; i++) {
                const nr = r + dr[i];
                const nc = c + dc[i];

                // Check boundary conditions, cell value, and if already visited
                if (nr >= 0 && nr < m && nc >= 0 && nc < n &&
                    currentGrid[nr][nc] === 1 && !pathVisited[nr][nc]) {
                    pathVisited[nr][nc] = true;
                    queue.push([nr, nc]);
                }
            }
        }
        // If the queue becomes empty and target was not reached, no path exists
        return false;
    }

    // Edge case 1: If the start or end cell is 0, it's already disconnected.
    // This counts as 0 flips, so it's possible.
    if (grid[0][0] === 0 || grid[m - 1][n - 1] === 0) {
        return true;
    }

    // Step 1: Check if a path exists initially.
    // If no path exists, it's already disconnected (0 flips needed).
    if (!checkPath(0, 0, m - 1, n - 1, grid)) {
        return true;
    }

    // Step 2: Iterate through each intermediate '1' cell and try flipping it to '0'.
    // An intermediate cell is any cell (r, c) where grid[r][c] == 1,
    // and it's not the start (0,0) or the end (m-1, n-1).
    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            // Only consider flipping '1' cells that are not the start or end
            if (grid[r][c] === 1 && (r !== 0 || c !== 0) && (r !== m - 1 || c !== n - 1)) {
                grid[r][c] = 0; // Temporarily flip the cell to 0

                // Check if a path still exists after flipping this cell.
                // If no path exists, then this single flip successfully disconnected all paths.
                if (!checkPath(0, 0, m - 1, n - 1, grid)) {
                    grid[r][c] = 1; // Backtrack: restore the cell to 1 for subsequent checks
                    return true; // Found a single flip that disconnects all paths
                }

                grid[r][c] = 1; // Backtrack: restore the cell to 1
            }
        }
    }

    // If the loop completes, it means no single flip (of an intermediate cell)
    // was able to disconnect all paths.
    return false;
};
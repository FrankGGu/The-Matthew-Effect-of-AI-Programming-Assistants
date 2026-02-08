var numEnclaves = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    function dfs(r, c) {
        // Base cases: out of bounds, or current cell is water (0), or already visited (marked 0)
        if (r < 0 || r >= m || c < 0 || c >= n || grid[r][c] === 0) {
            return;
        }

        // Mark the current land cell as visited by changing it to 0.
        // This effectively "drowns" the land cell and prevents revisiting.
        grid[r][c] = 0;

        // Recursively explore all four adjacent cells
        dfs(r + 1, c); // Down
        dfs(r - 1, c); // Up
        dfs(r, c + 1); // Right
        dfs(r, c - 1); // Left
    }

    // Perform DFS from all land cells connected to the grid boundaries.
    // These are the land cells that are NOT enclaves.

    // Traverse the top and bottom rows
    for (let j = 0; j < n; j++) {
        // Top row
        if (grid[0][j] === 1) {
            dfs(0, j);
        }
        // Bottom row
        if (grid[m - 1][j] === 1) {
            dfs(m - 1, j);
        }
    }

    // Traverse the left and right columns
    // Note: The corner cells (0,0), (0,n-1), (m-1,0), (m-1,n-1) will be checked twice,
    // but the DFS function handles this by returning if the cell is already marked 0.
    for (let i = 0; i < m; i++) {
        // Left column
        if (grid[i][0] === 1) {
            dfs(i, 0);
        }
        // Right column
        if (grid[i][n - 1] === 1) {
            dfs(i, n - 1);
        }
    }

    // After all boundary-connected land cells are marked 0,
    // count the remaining '1's in the grid. These are the enclaves.
    let enclavesCount = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                enclavesCount++;
            }
        }
    }

    return enclavesCount;
};
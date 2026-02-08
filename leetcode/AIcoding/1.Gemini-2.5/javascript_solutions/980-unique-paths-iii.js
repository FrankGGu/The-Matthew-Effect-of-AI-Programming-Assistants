var uniquePathsIII = function(grid) {
    let rows = grid.length;
    let cols = grid[0].length;

    let start_r, start_c;
    let total_non_obstacle_squares = 0;

    // Find the starting point and count all non-obstacle squares
    for (let r = 0; r < rows; r++) {
        for (let c = 0; c < cols; c++) {
            if (grid[r][c] === 1) {
                start_r = r;
                start_c = c;
            }
            // Count 0 (empty), 1 (start), and 2 (end) squares
            if (grid[r][c] !== -1) {
                total_non_obstacle_squares++;
            }
        }
    }

    let path_count = 0;

    // DFS function to explore paths
    function dfs(r, c, current_walk_count) {
        // Base cases for invalid moves or obstacles
        if (r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] === -1) {
            return;
        }

        // If we reached the ending square (2)
        if (grid[r][c] === 2) {
            // Check if all non-obstacle squares have been visited
            if (current_walk_count === total_non_obstacle_squares) {
                path_count++;
            }
            return;
        }

        // Mark the current cell as visited by temporarily changing its value
        // Store original value to backtrack
        let original_val = grid[r][c];
        grid[r][c] = -1; // Mark as visited (temporarily an obstacle)

        // Explore all 4 directions
        dfs(r + 1, c, current_walk_count + 1); // Down
        dfs(r - 1, c, current_walk_count + 1); // Up
        dfs(r, c + 1, current_walk_count + 1); // Right
        dfs(r, c - 1, current_walk_count + 1); // Left

        // Backtrack: restore the cell's original value
        grid[r][c] = original_val;
    }

    // Start DFS from the starting square (1)
    // The initial current_walk_count is 1 because the starting square itself counts as one visited square.
    dfs(start_r, start_c, 1);

    return path_count;
};
var minimumVisitedCells = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    if (m === 1 && n === 1) {
        return 1;
    }

    const dist = Array(m).fill(0).map(() => Array(n).fill(Infinity));
    dist[0][0] = 1;

    const queue = [[0, 0]];

    // DSU for rows: parent_cols[r][j] stores the next unvisited column index >= j in row r
    // Initialize parent_cols[r][j] = j for all j, and parent_cols[r][n] = n as a sentinel
    const parent_cols = Array(m).fill(0).map(() => Array(n + 1).fill(0).map((_, j) => j));

    // DSU for columns: parent_rows[c][i] stores the next unvisited row index >= i in column c
    // Initialize parent_rows[c][i] = i for all i, and parent_rows[c][m] = m as a sentinel
    const parent_rows = Array(n).fill(0).map(() => Array(m + 1).fill(0).map((_, i) => i));

    // Find function for DSU for columns
    const find_col = (r, j) => {
        if (parent_cols[r][j] === j) {
            return j;
        }
        // Path compression
        return parent_cols[r][j] = find_col(r, parent_cols[r][j]);
    };

    // Find function for DSU for rows
    const find_row = (c, i) => {
        if (parent_rows[c][i] === i) {
            return i;
        }
        // Path compression
        return parent_rows[c][i] = find_row(c, parent_rows[c][i]);
    };

    let head = 0;
    while (head < queue.length) {
        const [r, c] = queue[head++];
        const current_dist = dist[r][c];

        // Process horizontal moves
        // The maximum column index reachable from (r, c)
        const max_col_jump = Math.min(n - 1, c + grid[r][c]);

        // Find the first unvisited column strictly greater than c in row r
        let next_unvisited_j = find_col(r, c + 1);

        // Iterate through all reachable unvisited columns
        while (next_unvisited_j <= max_col_jump) {
            if (dist[r][next_unvisited_j] === Infinity) { // If this cell has not been visited yet
                dist[r][next_unvisited_j] = current_dist + 1;
                queue.push([r, next_unvisited_j]);
            }
            // Mark next_unvisited_j as "visited" in DSU by pointing it to the next index.
            // This effectively "unions" next_unvisited_j with next_unvisited_j + 1,
            // so find_col(r, next_unvisited_j) will now return a value >= next_unvisited_j + 1.
            parent_cols[r][next_unvisited_j] = next_unvisited_j + 1;

            // Find the next unvisited column after next_unvisited_j
            next_unvisited_j = find_col(r, next_unvisited_j + 1);
        }

        // Process vertical moves
        // The maximum row index reachable from (r, c)
        const max_row_jump = Math.min(m - 1, r + grid[r][c]);

        // Find the first unvisited row strictly greater than r in column c
        let next_unvisited_i = find_row(c, r + 1);

        // Iterate through all reachable unvisited rows
        while (next_unvisited_i <= max_row_jump) {
            if (dist[next_unvisited_i][c] === Infinity) { // If this cell has not been visited yet
                dist[next_unvisited_i][c] = current_dist + 1;
                queue.push([next_unvisited_i, c]);
            }
            // Mark next_unvisited_i as "visited" in DSU
            parent_rows[c][next_unvisited_i] = next_unvisited_i + 1;

            // Find the next unvisited row after next_unvisited_i
            next_unvisited_i = find_row(c, next_unvisited_i + 1);
        }
    }

    return dist[m - 1][n - 1] === Infinity ? -1 : dist[m - 1][n - 1];
};
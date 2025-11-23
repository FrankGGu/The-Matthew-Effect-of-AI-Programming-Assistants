var minimumOperations = function(grid) {
    const n = grid.length;
    const mid = Math.floor(n / 2);

    let y_counts = [0, 0, 0];
    let non_y_counts = [0, 0, 0];
    let total_y_cells = 0;

    for (let r = 0; r < n; r++) {
        for (let c = 0; c < n; c++) {
            let is_y_cell = false;

            // Check for the vertical stem of 'Y'
            // This covers cells (mid, mid) to (n-1, mid)
            if (c === mid && r >= mid) {
                is_y_cell = true;
            }
            // Check for the diagonal arms of 'Y'
            // This covers cells from r=0 to r=mid-1 along the diagonals
            else if (r < mid && (r === c || r + c === n - 1)) {
                is_y_cell = true;
            }

            if (is_y_cell) {
                y_counts[grid[r][c]]++;
                total_y_cells++;
            } else {
                non_y_counts[grid[r][c]]++;
            }
        }
    }

    const total_non_y_cells = n * n - total_y_cells;
    let min_ops = Infinity;

    for (let color_y = 0; color_y < 3; color_y++) {
        for (let color_non_y = 0; color_non_y < 3; color_non_y++) {
            if (color_y !== color_non_y) {
                const current_ops = (total_y_cells - y_counts[color_y]) +
                                    (total_non_y_cells - non_y_counts[color_non_y]);
                min_ops = Math.min(min_ops, current_ops);
            }
        }
    }

    return min_ops;
};
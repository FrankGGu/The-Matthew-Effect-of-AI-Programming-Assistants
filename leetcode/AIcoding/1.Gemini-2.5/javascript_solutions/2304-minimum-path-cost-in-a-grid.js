var minPathCost = function(grid, moveCost) {
    const m = grid.length;
    const n = grid[0].length;

    let prev_dp = [...grid[0]];

    for (let r = 1; r < m; r++) {
        let curr_dp = new Array(n).fill(Infinity);
        for (let c = 0; c < n; c++) {
            for (let prev_c = 0; prev_c < n; prev_c++) {
                const prev_cell_value = grid[r - 1][prev_c];
                const cost_from_prev = prev_dp[prev_c] + moveCost[prev_cell_value][c];
                curr_dp[c] = Math.min(curr_dp[c], cost_from_prev);
            }
            curr_dp[c] += grid[r][c];
        }
        prev_dp = curr_dp;
    }

    let min_total_cost = Infinity;
    for (let c = 0; c < n; c++) {
        min_total_cost = Math.min(min_total_cost, prev_dp[c]);
    }

    return min_total_cost;
};
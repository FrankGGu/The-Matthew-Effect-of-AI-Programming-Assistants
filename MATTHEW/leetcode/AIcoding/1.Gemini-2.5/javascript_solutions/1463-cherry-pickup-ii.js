var cherryPickup = function(grid) {
    const rows = grid.length;
    const cols = grid[0].length;

    const dp = Array(rows).fill(0).map(() =>
        Array(cols).fill(0).map(() =>
            Array(cols).fill(-1)
        )
    );

    dp[0][0][cols - 1] = grid[0][0] + (0 === cols - 1 ? 0 : grid[0][cols - 1]);

    for (let r = 0; r < rows - 1; r++) {
        for (let c1 = 0; c1 < cols; c1++) {
            for (let c2 = 0; c2 < cols; c2++) {
                if (dp[r][c1][c2] === -1) {
                    continue;
                }

                for (let move1 = -1; move1 <= 1; move1++) {
                    const next_c1 = c1 + move1;

                    if (next_c1 < 0 || next_c1 >= cols) {
                        continue;
                    }

                    for (let move2 = -1; move2 <= 1; move2++) {
                        const next_c2 = c2 + move2;

                        if (next_c2 < 0 || next_c2 >= cols) {
                            continue;
                        }

                        let cherries_at_next_row = grid[r + 1][next_c1];
                        if (next_c1 !== next_c2) {
                            cherries_at_next_row += grid[r + 1][next_c2];
                        }

                        dp[r + 1][next_c1][next_c2] = Math.max(
                            dp[r + 1][next_c1][next_c2],
                            dp[r][c1][c2] + cherries_at_next_row
                        );
                    }
                }
            }
        }
    }

    let maxCherries = 0;
    for (let c1 = 0; c1 < cols; c1++) {
        for (let c2 = 0; c2 < cols; c2++) {
            maxCherries = Math.max(maxCherries, dp[rows - 1][c1][c2]);
        }
    }

    return maxCherries;
};
var countSubmatrices = function(grid, x, y) {
    const m = grid.length;
    const n = grid[0].length;
    let count = 0;

    for (let r1 = 0; r1 < m; r1++) {
        for (let c1 = 0; c1 < n; c1++) {
            for (let r2 = r1; r2 < m; r2++) {
                for (let c2 = c1; c2 < n; c2++) {
                    let xCount = 0;
                    let yCount = 0;

                    for (let i = r1; i <= r2; i++) {
                        for (let j = c1; j <= c2; j++) {
                            if (grid[i][j] === x) {
                                xCount++;
                            } else if (grid[i][j] === y) {
                                yCount++;
                            }
                        }
                    }

                    if (xCount === yCount) {
                        count++;
                    }
                }
            }
        }
    }

    return count;
};
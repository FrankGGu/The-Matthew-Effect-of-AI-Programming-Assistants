function largest1BorderedSquare(grid) {
    const m = grid.length;
    const n = grid[0].length;
    let max = 0;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                let side = 1;
                while (i + side < m && j + side < n) {
                    if (grid[i][j + side] === 1 && grid[i + side][j] === 1) {
                        let valid = true;
                        for (let k = 1; k < side; k++) {
                            if (grid[i][j + k] !== 1 || grid[i + k][j] !== 1 || grid[i + side][j + k] !== 1 || grid[i + k][j + side] !== 1) {
                                valid = false;
                                break;
                            }
                        }
                        if (valid) {
                            side++;
                        } else {
                            break;
                        }
                    } else {
                        break;
                    }
                }
                max = Math.max(max, side);
            }
        }
    }

    return max * max;
}
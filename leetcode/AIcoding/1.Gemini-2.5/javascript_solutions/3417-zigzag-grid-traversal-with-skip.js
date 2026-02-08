var zigzagGridTraversalWithSkip = function(grid) {
    const m = grid.length;
    if (m === 0) return [];
    const n = grid[0].length;
    if (n === 0) return [];

    const result = [];
    let r = 0, c = 0;
    let direction = 1; // 1 for up-right (r--, c++), -1 for down-left (r++, c--)

    while (r >= 0 && r < m && c >= 0 && c < n) {
        result.push(grid[r][c]);

        let totalStepsToAdvance = grid[r][c] + 1;

        for (let i = 0; i < totalStepsToAdvance; i++) {
            if (direction === 1) {
                r--;
                c++;
            } else {
                r++;
                c--;
            }

            if (r < 0 || r >= m || c < 0 || c >= n) {
                if (direction === 1) {
                    r++;
                    c--;
                } else {
                    r--;
                    c++;
                }

                direction *= -1;

                if (direction === 1) {
                    if (c < n - 1) {
                        c++;
                    } else {
                        r++;
                    }
                } else {
                    if (r < m - 1) {
                        r++;
                    } else {
                        c++;
                    }
                }
            }

            if (r < 0 || r >= m || c < 0 || c >= n) {
                break;
            }
        }
    }

    return result;
};
var possibleToStamp = function(grid, stampHeight, stampWidth) {
    let m = grid.length;
    let n = grid[0].length;

    let prefixSumGrid = Array(m + 1).fill(0).map(() => Array(n + 1).fill(0));

    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            prefixSumGrid[r + 1][c + 1] = grid[r][c] + prefixSumGrid[r][c + 1] + prefixSumGrid[r + 1][c] - prefixSumGrid[r][c];
        }
    }

    function getRectSum(r1, c1, r2, c2) {
        return prefixSumGrid[r2 + 1][c2 + 1] - prefixSumGrid[r1][c2 + 1] - prefixSumGrid[r2 + 1][c1] + prefixSumGrid[r1][c1];
    }

    let diff = Array(m).fill(0).map(() => Array(n).fill(0));

    for (let r = 0; r <= m - stampHeight; r++) {
        for (let c = 0; c <= n - stampWidth; c++) {
            if (getRectSum(r, c, r + stampHeight - 1, c + stampWidth - 1) === 0) {
                diff[r][c]++;
                if (c + stampWidth < n) {
                    diff[r][c + stampWidth]--;
                }
                if (r + stampHeight < m) {
                    diff[r + stampHeight][c]--;
                }
                if (r + stampHeight < m && c + stampWidth < n) {
                    diff[r + stampHeight][c + stampWidth]++;
                }
            }
        }
    }

    let coveredCount = Array(m).fill(0).map(() => Array(n).fill(0));
    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            coveredCount[r][c] = diff[r][c];
            if (r > 0) {
                coveredCount[r][c] += coveredCount[r - 1][c];
            }
            if (c > 0) {
                coveredCount[r][c] += coveredCount[r][c - 1];
            }
            if (r > 0 && c > 0) {
                coveredCount[r][c] -= coveredCount[r - 1][c - 1];
            }
        }
    }

    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            if (grid[r][c] === 0 && coveredCount[r][c] === 0) {
                return false;
            }
        }
    }

    return true;
};
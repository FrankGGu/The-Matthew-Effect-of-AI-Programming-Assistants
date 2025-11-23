var possibleToStamp = function(grid, stampHeight, stampWidth) {
    const m = grid.length;
    const n = grid[0].length;

    const prefixSum = Array(m + 1).fill(null).map(() => Array(n + 1).fill(0));
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            prefixSum[i + 1][j + 1] = prefixSum[i + 1][j] + prefixSum[i][j + 1] - prefixSum[i][j] + parseInt(grid[i][j]);
        }
    }

    const diff = Array(m).fill(null).map(() => Array(n).fill(0));
    for (let i = 0; i <= m - stampHeight; i++) {
        for (let j = 0; j <= n - stampWidth; j++) {
            const sum = prefixSum[i + stampHeight][j + stampWidth] - prefixSum[i + stampHeight][j] - prefixSum[i][j + stampWidth] + prefixSum[i][j];
            if (sum === 0) {
                diff[i][j]++;
                if (i + stampHeight < m) diff[i + stampHeight][j]--;
                if (j + stampWidth < n) diff[i][j + stampWidth]--;
                if (i + stampHeight < m && j + stampWidth < n) diff[i + stampHeight][j + stampWidth]++;
            }
        }
    }

    const stampCount = Array(m).fill(null).map(() => Array(n).fill(0));
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            stampCount[i][j] = (i > 0 ? stampCount[i - 1][j] : 0) + (j > 0 ? stampCount[i][j - 1] : 0) - (i > 0 && j > 0 ? stampCount[i - 1][j - 1] : 0) + diff[i][j];
        }
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === '0' && stampCount[i][j] === 0) {
                return false;
            }
        }
    }

    return true;
};
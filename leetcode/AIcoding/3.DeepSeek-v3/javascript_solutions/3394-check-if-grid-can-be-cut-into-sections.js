var possibleToStamp = function(grid, stampHeight, stampWidth) {
    const m = grid.length;
    const n = grid[0].length;

    const prefix = Array(m + 1).fill().map(() => Array(n + 1).fill(0));
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            prefix[i + 1][j + 1] = grid[i][j] + prefix[i][j + 1] + prefix[i + 1][j] - prefix[i][j];
        }
    }

    const diff = Array(m + 2).fill().map(() => Array(n + 2).fill(0));
    for (let i = stampHeight; i <= m; i++) {
        for (let j = stampWidth; j <= n; j++) {
            const x = i - stampHeight + 1;
            const y = j - stampWidth + 1;
            const sum = prefix[i][j] - prefix[x - 1][j] - prefix[i][y - 1] + prefix[x - 1][y - 1];
            if (sum === 0) {
                diff[x][y]++;
                diff[x][j + 1]--;
                diff[i + 1][y]--;
                diff[i + 1][j + 1]++;
            }
        }
    }

    for (let i = 1; i <= m; i++) {
        for (let j = 1; j <= n; j++) {
            diff[i][j] += diff[i - 1][j] + diff[i][j - 1] - diff[i - 1][j - 1];
            if (grid[i - 1][j - 1] === 0 && diff[i][j] === 0) {
                return false;
            }
        }
    }

    return true;
};
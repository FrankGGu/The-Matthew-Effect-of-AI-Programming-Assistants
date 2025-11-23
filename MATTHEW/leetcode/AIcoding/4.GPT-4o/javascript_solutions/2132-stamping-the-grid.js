var canStamp = function(grid, stamp, target) {
    const m = grid.length, n = grid[0].length;
    const stampH = stamp.length, stampW = stamp[0].length;

    const check = (i, j) => {
        for (let x = 0; x < stampH; x++) {
            for (let y = 0; y < stampW; y++) {
                if (stamp[x][y] === '1' && grid[i + x][j + y] === '0') {
                    return false;
                }
            }
        }
        return true;
    };

    const applyStamp = (i, j) => {
        for (let x = 0; x < stampH; x++) {
            for (let y = 0; y < stampW; y++) {
                if (stamp[x][y] === '1') {
                    grid[i + x][j + y] = '0';
                }
            }
        }
    };

    for (let i = 0; i <= m - stampH; i++) {
        for (let j = 0; j <= n - stampW; j++) {
            if (check(i, j)) {
                applyStamp(i, j);
            }
        }
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === '1') {
                return false;
            }
        }
    }
    return true;
};
var largest1BorderedSquare = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const left = new Array(m).fill().map(() => new Array(n).fill(0));
    const top = new Array(m).fill().map(() => new Array(n).fill(0));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                left[i][j] = (j === 0) ? 1 : left[i][j - 1] + 1;
                top[i][j] = (i === 0) ? 1 : top[i - 1][j] + 1;
            }
        }
    }

    let maxLen = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            let len = Math.min(left[i][j], top[i][j]);
            while (len > maxLen) {
                const k = i - len + 1;
                const l = j - len + 1;
                if (k >= 0 && l >= 0 && top[i][l] >= len && left[k][j] >= len) {
                    maxLen = len;
                    break;
                }
                len--;
            }
        }
    }

    return maxLen * maxLen;
};
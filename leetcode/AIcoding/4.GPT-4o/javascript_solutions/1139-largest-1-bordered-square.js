var largest1BorderedSquare = function(grid) {
    const m = grid.length, n = grid[0].length;
    const left = Array.from({length: m}, () => Array(n).fill(0));
    const top = Array.from({length: m}, () => Array(n).fill(0));
    let maxSize = 0;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                left[i][j] = (j === 0 ? 0 : left[i][j - 1]) + 1;
                top[i][j] = (i === 0 ? 0 : top[i - 1][j]) + 1;
                const side = Math.min(left[i][j], top[i][j]);
                for (let k = side; k > 0; k--) {
                    if (top[i][j - k + 1] >= k && left[i - k + 1][j] >= k) {
                        maxSize = Math.max(maxSize, k);
                        break;
                    }
                }
            }
        }
    }

    return maxSize * maxSize;
};
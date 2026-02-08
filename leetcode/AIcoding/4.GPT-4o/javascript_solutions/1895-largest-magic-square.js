var largestMagicSquare = function(grid) {
    const m = grid.length, n = grid[0].length;
    const prefixSum = Array.from({length: m + 1}, () => Array(n + 1).fill(0));

    for (let i = 1; i <= m; i++) {
        for (let j = 1; j <= n; j++) {
            prefixSum[i][j] = grid[i - 1][j - 1] + prefixSum[i - 1][j] + prefixSum[i][j - 1] - prefixSum[i - 1][j - 1];
        }
    }

    const isMagicSquare = (r, c, size) => {
        const sum = size * (size * (size - 1) / 2 + 1);
        let diag1 = 0, diag2 = 0;
        for (let i = 0; i < size; i++) {
            diag1 += grid[r + i][c + i];
            diag2 += grid[r + i][c + size - 1 - i];
            let rowSum = 0, colSum = 0;
            for (let j = 0; j < size; j++) {
                rowSum += grid[r + i][c + j];
                colSum += grid[r + j][c + i];
            }
            if (rowSum !== sum || colSum !== sum) return false;
        }
        return diag1 === sum && diag2 === sum;
    };

    let maxMagicSize = 1;
    for (let size = 2; size <= Math.min(m, n); size++) {
        for (let i = 0; i <= m - size; i++) {
            for (let j = 0; j <= n - size; j++) {
                if (isMagicSquare(i, j, size)) {
                    maxMagicSize = size;
                }
            }
        }
    }
    return maxMagicSize;
};
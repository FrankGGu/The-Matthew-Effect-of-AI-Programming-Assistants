var largestMagicSquare = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const rowSum = Array.from({ length: m }, () => new Array(n).fill(0));
    const colSum = Array.from({ length: m }, () => new Array(n).fill(0));
    const diagSum = Array.from({ length: m }, () => new Array(n).fill(0));
    const antiDiagSum = Array.from({ length: m }, () => new Array(n).fill(0));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            rowSum[i][j] = (j > 0 ? rowSum[i][j - 1] : 0) + grid[i][j];
            colSum[i][j] = (i > 0 ? colSum[i - 1][j] : 0) + grid[i][j];
            diagSum[i][j] = (i > 0 && j > 0 ? diagSum[i - 1][j - 1] : 0) + grid[i][j];
            antiDiagSum[i][j] = (i > 0 && j < n - 1 ? antiDiagSum[i - 1][j + 1] : 0) + grid[i][j];
        }
    }

    let maxSize = 1;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            for (let k = Math.min(m - i, n - j); k > maxSize; k--) {
                const target = diagSum[i + k - 1][j + k - 1] - (i > 0 && j > 0 ? diagSum[i - 1][j - 1] : 0);
                let valid = true;

                for (let l = 0; l < k && valid; l++) {
                    const row = rowSum[i + l][j + k - 1] - (j > 0 ? rowSum[i + l][j - 1] : 0);
                    const col = colSum[i + k - 1][j + l] - (i > 0 ? colSum[i - 1][j + l] : 0);
                    const antiDiag = antiDiagSum[i + l][j + k - 1 - l] - (i > 0 && j + k - 1 - l < n - 1 ? antiDiagSum[i - 1][j + k - l] : 0);

                    if (row !== target || col !== target || antiDiag !== target) {
                        valid = false;
                    }
                }

                if (valid) {
                    maxSize = k;
                    break;
                }
            }
        }
    }

    return maxSize;
};
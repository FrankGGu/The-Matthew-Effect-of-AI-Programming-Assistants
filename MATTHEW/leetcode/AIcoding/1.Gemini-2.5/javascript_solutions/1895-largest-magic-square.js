var largestMagicSquare = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    const prefixRow = Array(m).fill(0).map(() => Array(n + 1).fill(0));
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            prefixRow[i][j + 1] = prefixRow[i][j] + grid[i][j];
        }
    }

    const prefixCol = Array(m + 1).fill(0).map(() => Array(n).fill(0));
    for (let j = 0; j < n; j++) {
        for (let i = 0; i < m; i++) {
            prefixCol[i + 1][j] = prefixCol[i][j] + grid[i][j];
        }
    }

    for (let k = Math.min(m, n); k >= 1; k--) {
        for (let r = 0; r <= m - k; r++) {
            for (let c = 0; c <= n - k; c++) {
                let isCurrentSquareMagic = true;

                const targetSum = prefixRow[r][c + k] - prefixRow[r][c];

                for (let i = 0; i < k; i++) {
                    if (prefixRow[r + i][c + k] - prefixRow[r + i][c] !== targetSum) {
                        isCurrentSquareMagic = false;
                        break;
                    }
                }
                if (!isCurrentSquareMagic) continue;

                for (let j = 0; j < k; j++) {
                    if (prefixCol[r + k][c + j] - prefixCol[r][c + j] !== targetSum) {
                        isCurrentSquareMagic = false;
                        break;
                    }
                }
                if (!isCurrentSquareMagic) continue;

                let diagSum1 = 0;
                for (let i = 0; i < k; i++) {
                    diagSum1 += grid[r + i][c + i];
                }
                if (diagSum1 !== targetSum) {
                    isCurrentSquareMagic = false;
                }
                if (!isCurrentSquareMagic) continue;

                let diagSum2 = 0;
                for (let i = 0; i < k; i++) {
                    diagSum2 += grid[r + i][c + k - 1 - i];
                }
                if (diagSum2 !== targetSum) {
                    isCurrentSquareMagic = false;
                }
                if (!isCurrentSquareMagic) continue;

                return k;
            }
        }
    }

    return 1;
};
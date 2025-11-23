var largestMagicSquare = function(grid) {
    const n = grid.length;
    const m = grid[0].length;

    const sum = (arr) => arr.reduce((acc, curr) => acc + curr, 0);

    const isMagicSquare = (r, c, k) => {
        let expectedSum = 0;
        for (let i = 0; i < k; i++) {
            expectedSum += grid[r][c + i];
        }

        for (let i = 0; i < k; i++) {
            let rowSum = 0;
            for (let j = 0; j < k; j++) {
                rowSum += grid[r + i][c + j];
            }
            if (rowSum !== expectedSum) return false;
        }

        for (let j = 0; j < k; j++) {
            let colSum = 0;
            for (let i = 0; i < k; i++) {
                colSum += grid[r + i][c + j];
            }
            if (colSum !== expectedSum) return false;
        }

        let diag1Sum = 0;
        for (let i = 0; i < k; i++) {
            diag1Sum += grid[r + i][c + i];
        }
        if (diag1Sum !== expectedSum) return false;

        let diag2Sum = 0;
        for (let i = 0; i < k; i++) {
            diag2Sum += grid[r + i][c + k - 1 - i];
        }
        if (diag2Sum !== expectedSum) return false;

        return true;
    };

    let maxK = 1;
    for (let k = Math.min(n, m); k > 1; k--) {
        for (let r = 0; r <= n - k; r++) {
            for (let c = 0; c <= m - k; c++) {
                if (isMagicSquare(r, c, k)) {
                    return k;
                }
            }
        }
    }

    return maxK;
};
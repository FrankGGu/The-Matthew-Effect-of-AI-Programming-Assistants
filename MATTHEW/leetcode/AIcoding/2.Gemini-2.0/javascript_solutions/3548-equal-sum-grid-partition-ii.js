var equalSumGrid = function(grid) {
    const n = grid.length;
    let ans = 0;

    const prefixSum = Array(n).fill(null).map(() => Array(n).fill(0));
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            prefixSum[i][j] = grid[i][j];
            if (i > 0) prefixSum[i][j] += prefixSum[i - 1][j];
            if (j > 0) prefixSum[i][j] += prefixSum[i][j - 1];
            if (i > 0 && j > 0) prefixSum[i][j] -= prefixSum[i - 1][j - 1];
        }
    }

    for (let r1 = 0; r1 < n; r1++) {
        for (let c1 = 0; c1 < n; c1++) {
            for (let r2 = r1; r2 < n; r2++) {
                for (let c2 = c1; c2 < n; c2++) {
                    let sum1 = prefixSum[r2][c2];
                    if (r1 > 0) sum1 -= prefixSum[r1 - 1][c2];
                    if (c1 > 0) sum1 -= prefixSum[r2][c1 - 1];
                    if (r1 > 0 && c1 > 0) sum1 += prefixSum[r1 - 1][c1 - 1];

                    let sum2 = prefixSum[n - 1][n - 1] - sum1;

                    if (sum1 === sum2) {
                        ans++;
                    }
                }
            }
        }
    }

    return ans;
};
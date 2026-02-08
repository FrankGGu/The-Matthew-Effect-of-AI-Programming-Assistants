var minFallingPathSum = function(matrix) {
    const n = matrix.length;
    let dp = [...matrix[0]];

    for (let i = 1; i < n; i++) {
        const newDp = new Array(n).fill(Infinity);
        for (let j = 0; j < n; j++) {
            for (let k = 0; k < n; k++) {
                if (j !== k) {
                    newDp[j] = Math.min(newDp[j], dp[k] + matrix[i][j]);
                }
            }
        }
        dp = newDp;
    }

    let minSum = Infinity;
    for (let i = 0; i < n; i++) {
        minSum = Math.min(minSum, dp[i]);
    }

    return minSum;
};
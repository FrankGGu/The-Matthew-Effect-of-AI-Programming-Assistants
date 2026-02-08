var maximalSquare = function(matrix) {
    if (!matrix || matrix.length === 0 || matrix[0].length === 0) {
        return 0;
    }

    const m = matrix.length;
    const n = matrix[0].length;

    const dp = new Array(n + 1).fill(0);
    let maxSide = 0;

    let prev_diag_val = 0; 

    for (let i = 0; i < m; i++) {
        prev_diag_val = 0; 
        for (let j = 0; j < n; j++) {
            const temp_curr_dp_val = dp[j + 1]; 

            if (matrix[i][j] === '1') {
                dp[j + 1] = 1 + Math.min(dp[j], dp[j + 1], prev_diag_val);
                maxSide = Math.max(maxSide, dp[j + 1]);
            } else {
                dp[j + 1] = 0;
            }
            prev_diag_val = temp_curr_dp_val; 
        }
    }

    return maxSide * maxSide;
};
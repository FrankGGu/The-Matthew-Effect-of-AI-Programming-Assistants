var numSubmat = function(mat) {
    const m = mat.length;
    const n = mat[0].length;
    let dp = Array(m).fill(null).map(() => Array(n).fill(0));
    let ans = 0;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (mat[i][j] === 1) {
                dp[i][j] = (j === 0) ? 1 : dp[i][j - 1] + 1;
                let width = dp[i][j];
                let minWidth = width;
                for (let k = i; k >= 0; k--) {
                    minWidth = Math.min(minWidth, dp[k][j]);
                    ans += minWidth;
                }
            }
        }
    }

    return ans;
};
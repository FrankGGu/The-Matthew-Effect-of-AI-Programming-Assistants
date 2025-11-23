var findMaxForm = function(strs, m, n) {
    const dp = Array(m + 1).fill(null).map(() => Array(n + 1).fill(0));

    for (const str of strs) {
        let zeros = 0;
        let ones = 0;
        for (const char of str) {
            if (char === '0') {
                zeros++;
            } else {
                ones++;
            }
        }

        for (let i = m; i >= zeros; i--) {
            for (let j = n; j >= ones; j--) {
                dp[i][j] = Math.max(dp[i][j], dp[i - zeros][j - ones] + 1);
            }
        }
    }

    return dp[m][n];
};
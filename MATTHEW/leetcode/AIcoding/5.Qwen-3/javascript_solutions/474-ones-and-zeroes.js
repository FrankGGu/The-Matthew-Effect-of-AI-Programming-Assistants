function findMaxForm(strs, m, n) {
    const dp = new Array(m + 1).fill(0).map(() => new Array(n + 1).fill(0));

    for (const str of strs) {
        let ones = 0, zeros = 0;
        for (const c of str) {
            if (c === '0') zeros++;
            else ones++;
        }

        for (let i = m; i >= zeros; i--) {
            for (let j = n; j >= ones; j--) {
                dp[i][j] = Math.max(dp[i][j], dp[i - zeros][j - ones] + 1);
            }
        }
    }

    return dp[m][n];
}
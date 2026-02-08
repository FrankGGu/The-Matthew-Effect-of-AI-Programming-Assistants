var findMaxForm = function(strs, m, n) {
    const dp = Array(m + 1).fill(null).map(() => Array(n + 1).fill(0));

    for (const str of strs) {
        const count = [0, 0];
        for (const char of str) {
            count[char]++;
        }
        for (let i = m; i >= count[0]; i--) {
            for (let j = n; j >= count[1]; j--) {
                dp[i][j] = Math.max(dp[i][j], dp[i - count[0]][j - count[1]] + 1);
            }
        }
    }

    return dp[m][n];
};
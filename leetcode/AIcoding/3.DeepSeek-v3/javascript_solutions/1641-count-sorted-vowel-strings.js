var countVowelStrings = function(n) {
    let dp = Array(5).fill(1);
    for (let i = 2; i <= n; i++) {
        for (let j = 1; j < 5; j++) {
            dp[j] += dp[j - 1];
        }
    }
    return dp.reduce((a, b) => a + b, 0);
};
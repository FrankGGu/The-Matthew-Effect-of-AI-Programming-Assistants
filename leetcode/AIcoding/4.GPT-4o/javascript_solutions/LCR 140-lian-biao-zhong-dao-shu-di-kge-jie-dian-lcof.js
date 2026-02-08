var trainingPlan = function(n, m, calories) {
    let dp = new Array(n + 1).fill(0);
    for (let i = 0; i < m; i++) {
        for (let j = n; j >= calories[i]; j--) {
            dp[j] = Math.max(dp[j], dp[j - calories[i]] + calories[i]);
        }
    }
    return dp[n];
};
var minNumberOfLevels = function(energy, points) {
    let n = energy.length;
    let sum = 0;
    for (let i = 0; i < n; i++) {
        sum += points[i];
    }
    let dp = new Array(sum + 1).fill(Infinity);
    dp[0] = 0;
    for (let i = 0; i < n; i++) {
        for (let j = sum; j >= points[i]; j--) {
            dp[j] = Math.min(dp[j], dp[j - points[i]] + energy[i]);
        }
    }
    let ans = Infinity;
    for (let j = 0; j <= sum; j++) {
        if (dp[j] <= energy[n - 1]) {
            ans = Math.min(ans, energy[n - 1] - dp[j]);
        }
    }
    return ans;
};
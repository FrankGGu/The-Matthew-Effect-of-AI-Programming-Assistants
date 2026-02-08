var maximumEnergy = function(energy, k) {
    const n = energy.length;
    const dp = new Array(n);

    for (let i = n - 1; i >= 0; i--) {
        dp[i] = energy[i];
        if (i + k < n) {
            dp[i] += dp[i + k];
        }
    }

    let maxEnergy = -Infinity;
    for (let i = 0; i < n; i++) {
        maxEnergy = Math.max(maxEnergy, dp[i]);
    }

    return maxEnergy;
};
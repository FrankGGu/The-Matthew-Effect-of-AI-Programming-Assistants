var maximumTotalDamage = function(power) {
    const freq = {};
    for (const num of power) {
        freq[num] = (freq[num] || 0) + 1;
    }
    const unique = Object.keys(freq).map(Number).sort((a, b) => a - b);
    const n = unique.length;
    if (n === 0) return 0;

    const dp = new Array(n).fill(0);
    dp[0] = unique[0] * freq[unique[0]];

    for (let i = 1; i < n; i++) {
        let maxPrev = 0;
        for (let j = i - 1; j >= 0; j--) {
            if (unique[j] < unique[i] - 2) {
                maxPrev = Math.max(maxPrev, dp[j]);
                break;
            }
        }
        dp[i] = Math.max(
            (i > 0 ? dp[i - 1] : 0),
            unique[i] * freq[unique[i]] + maxPrev
        );
    }

    return dp[n - 1];
};
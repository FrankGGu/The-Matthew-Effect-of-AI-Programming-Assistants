var minOperations = function(s1, s2, x) {
    const n = s1.length;
    const diffIndices = [];
    for (let i = 0; i < n; i++) {
        if (s1[i] !== s2[i]) {
            diffIndices.push(i);
        }
    }
    const m = diffIndices.length;
    if (m % 2 !== 0) {
        return -1;
    }
    if (m === 0) {
        return 0;
    }

    const dp = new Array(m + 1).fill(Infinity);
    dp[0] = 0;
    for (let i = 1; i <= m; i++) {
        if (i % 2 === 0) {
            dp[i] = dp[i - 1];
        } else {
            dp[i] = dp[i - 1] + x;
        }
        if (i >= 2) {
            const cost = diffIndices[i - 1] - diffIndices[i - 2];
            dp[i] = Math.min(dp[i], dp[i - 2] + cost);
        }
    }
    return dp[m];
};
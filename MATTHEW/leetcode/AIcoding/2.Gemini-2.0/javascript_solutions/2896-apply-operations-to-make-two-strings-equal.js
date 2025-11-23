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

    if (x >= n) {
        return m / 2;
    }

    const dp = new Array(m + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 2; i <= m; i += 2) {
        dp[i] = Math.min(dp[i - 2] + Math.min(x, diffIndices[i - 1] - diffIndices[i - 2]), dp[i - 1]);
    }

    return dp[m];
};
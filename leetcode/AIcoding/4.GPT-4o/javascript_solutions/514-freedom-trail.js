var findRotateSteps = function(ring, key) {
    const n = ring.length, m = key.length;
    const dp = Array(m + 1).fill().map(() => Array(n).fill(Infinity));

    for (let i = 0; i < n; i++) {
        if (ring[i] === key[0]) {
            dp[0][i] = 1;
        }
    }

    for (let i = 1; i <= m; i++) {
        for (let j = 0; j < n; j++) {
            if (key[i - 1] === ring[j]) {
                for (let k = 0; k < n; k++) {
                    if (dp[i - 1][k] !== Infinity) {
                        const distance = Math.min(Math.abs(j - k), n - Math.abs(j - k));
                        dp[i][j] = Math.min(dp[i][j], dp[i - 1][k] + distance + 1);
                    }
                }
            }
        }
    }

    return Math.min(...dp[m]);
};
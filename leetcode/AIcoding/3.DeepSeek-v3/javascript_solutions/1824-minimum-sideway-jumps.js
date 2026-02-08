var minSideJumps = function(obstacles) {
    const n = obstacles.length - 1;
    const dp = new Array(n + 1).fill().map(() => new Array(3).fill(Infinity));

    dp[0][0] = 1;
    dp[0][1] = 0;
    dp[0][2] = 1;

    for (let i = 1; i <= n; i++) {
        for (let lane = 0; lane < 3; lane++) {
            if (obstacles[i] === lane + 1) {
                dp[i][lane] = Infinity;
            } else {
                dp[i][lane] = dp[i - 1][lane];
            }
        }

        for (let lane = 0; lane < 3; lane++) {
            if (obstacles[i] !== lane + 1) {
                const min = Math.min(
                    dp[i][(lane + 1) % 3],
                    dp[i][(lane + 2) % 3]
                );
                dp[i][lane] = Math.min(dp[i][lane], min + 1);
            }
        }
    }

    return Math.min(...dp[n]);
};
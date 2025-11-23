var minSideJumps = function(obstacles) {
    const n = obstacles.length;
    const dp = Array(n).fill(0).map(() => Array(4).fill(Infinity));
    dp[0][1] = 0; // Starting on lane 1 at position 0

    for (let i = 0; i < n; i++) {
        for (let lane = 1; lane <= 3; lane++) {
            if (obstacles[i] !== lane) {
                dp[i][lane] = Math.min(dp[i][lane], dp[i][lane]);
                if (i < n - 1) {
                    dp[i + 1][lane] = Math.min(dp[i + 1][lane], dp[i][lane]);
                }
                for (let nextLane = 1; nextLane <= 3; nextLane++) {
                    if (nextLane !== lane && obstacles[i] !== nextLane) {
                        dp[i][nextLane] = Math.min(dp[i][nextLane], dp[i][lane] + 1);
                    }
                }
            }
        }
    }

    return Math.min(dp[n - 1][1], dp[n - 1][2], dp[n - 1][3]);
};
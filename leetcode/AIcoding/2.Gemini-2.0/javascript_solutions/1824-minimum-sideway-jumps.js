var minSideJumps = function(obstacles) {
    const n = obstacles.length - 1;
    const dp = Array(3).fill(Infinity);
    dp[0] = 1;
    dp[1] = 0;
    dp[2] = 1;

    for (let i = 1; i <= n; i++) {
        for (let j = 0; j < 3; j++) {
            if (obstacles[i] === j + 1) {
                dp[j] = Infinity;
            }
        }

        let minVal = Math.min(...dp);

        for (let j = 0; j < 3; j++) {
            if (obstacles[i] !== j + 1) {
                dp[j] = Math.min(dp[j], minVal + 1);
            }
        }
    }

    return Math.min(...dp);
};
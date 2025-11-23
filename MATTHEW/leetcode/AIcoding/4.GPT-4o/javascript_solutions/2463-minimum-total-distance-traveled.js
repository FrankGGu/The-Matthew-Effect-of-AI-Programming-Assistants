var minimumTotalDistance = function(robot, factory) {
    const dp = Array(factory.length + 1).fill().map(() => Array(robot.length + 1).fill(Infinity));
    dp[0][0] = 0;

    for (let i = 0; i <= factory.length; i++) {
        for (let j = 0; j <= robot.length; j++) {
            if (i > 0) {
                dp[i][0] = 0;
            }
            for (let k = 1; k <= j; k++) {
                if (i > 0) {
                    dp[i][k] = Math.min(dp[i][k], dp[i - 1][k]);
                    const dist = factory[i - 1][0];
                    const limit = Math.min(factory[i - 1][1], k);
                    for (let m = 1; m <= limit; m++) {
                        dp[i][k] = Math.min(dp[i][k], dp[i - 1][k - m] + dist * m);
                    }
                }
            }
        }
    }
    return dp[factory.length][robot.length];
};
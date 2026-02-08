var numberOfWays = function(steps, arrLen) {
    const maxCol = Math.min(arrLen - 1, steps);
    const dp = new Array(maxCol + 1).fill(0);
    dp[0] = 1;

    for (let step = 0; step < steps; step++) {
        const newDp = new Array(maxCol + 1).fill(0);
        for (let col = 0; col <= maxCol; col++) {
            newDp[col] = dp[col]; // stay in the same place
            if (col > 0) newDp[col] = (newDp[col] + dp[col - 1]) % 1000000007; // move left
            if (col < maxCol) newDp[col] = (newDp[col] + dp[col + 1]) % 1000000007; // move right
        }
        dp = newDp;
    }

    return dp[0];
};
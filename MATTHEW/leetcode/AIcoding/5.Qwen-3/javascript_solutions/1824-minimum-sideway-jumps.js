function minSideJumps(obstacles) {
    let n = obstacles.length;
    let dp = [0, 1, 2];

    for (let i = 1; i < n; i++) {
        let newDp = [Infinity, Infinity, Infinity];
        for (let j = 0; j < 3; j++) {
            if (obstacles[i] === j + 1) continue;
            for (let k = 0; k < 3; k++) {
                if (obstacles[i] === k + 1) continue;
                if (j === k) {
                    newDp[j] = Math.min(newDp[j], dp[k]);
                } else {
                    newDp[j] = Math.min(newDp[j], dp[k] + 1);
                }
            }
        }
        dp = newDp;
    }

    return Math.min(...dp);
}
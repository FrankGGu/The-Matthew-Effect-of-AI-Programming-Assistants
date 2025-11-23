function minimumFinishTime(races, target) {
    const dp = new Array(target + 1).fill(Infinity);
    dp[0] = 0;

    for (const [time, speed] of races) {
        for (let i = target; i >= time; i--) {
            dp[i] = Math.min(dp[i], dp[i - time] + speed);
        }
    }

    return dp[target] === Infinity ? -1 : dp[target];
}
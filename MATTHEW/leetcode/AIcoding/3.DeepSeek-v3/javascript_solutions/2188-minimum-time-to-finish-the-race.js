var minimumFinishTime = function(tires, changeTime, numLaps) {
    const MAX = 1 << 30;
    const minTime = new Array(20).fill(MAX);
    for (const [f, r] of tires) {
        let time = f;
        let total = f;
        for (let lap = 1; lap <= 19; lap++) {
            minTime[lap] = Math.min(minTime[lap], total);
            time *= r;
            if (time > changeTime + f) break;
            total += time;
        }
    }

    const dp = new Array(numLaps + 1).fill(MAX);
    dp[0] = 0;
    for (let i = 1; i <= numLaps; i++) {
        for (let j = 1; j <= Math.min(19, i); j++) {
            dp[i] = Math.min(dp[i], dp[i - j] + minTime[j] + (i - j > 0 ? changeTime : 0));
        }
    }
    return dp[numLaps] - changeTime;
};
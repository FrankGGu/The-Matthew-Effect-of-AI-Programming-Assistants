var minimumFinishTime = function(tires, changeTime, numLaps) {
    const n = tires.length;
    const maxLap = Math.min(numLaps, 1000);
    const bestTime = new Array(maxLap + 1).fill(Infinity);
    bestTime[0] = 0;

    for (let i = 0; i < n; i++) {
        let f = tires[i][0];
        let r = tires[i][1];
        let totalTime = 0;
        for (let j = 1; j <= maxLap; j++) {
            totalTime += f;
            if (totalTime > 1000000) break;
            bestTime[j] = Math.min(bestTime[j], totalTime);
            f *= r;
        }
    }

    const dp = new Array(numLaps + 1).fill(Infinity);
    dp[0] = -changeTime;

    for (let i = 1; i <= numLaps; i++) {
        for (let j = 1; j <= Math.min(i, maxLap); j++) {
            dp[i] = Math.min(dp[i], dp[i - j] + bestTime[j] + changeTime);
        }
    }

    return dp[numLaps];
};
var minBatteryCharge = function(start, target, maxBattery, stations) {
    stations.unshift([start, 0]);
    stations.push([target, 0]);
    const n = stations.length;
    const dp = new Array(n).fill(Infinity);
    dp[0] = maxBattery;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const distance = stations[j][0] - stations[i][0];
            if (distance > maxBattery) break;
            const batteryNeeded = Math.max(0, dp[i] - distance);
            dp[j] = Math.min(dp[j], batteryNeeded + (j === n - 1 ? 0 : stations[j][1]));
        }
    }

    return dp[n - 1] === Infinity ? -1 : dp[n - 1];
};
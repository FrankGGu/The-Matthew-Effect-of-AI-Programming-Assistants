var minRefuelStops = function(target, startFuel, stations) {
    let dp = new Array(stations.length + 1).fill(0);
    dp[0] = startFuel;

    for (let i = 0; i < stations.length; i++) {
        for (let j = i + 1; j > 0; j--) {
            if (dp[j - 1] >= stations[i][0]) {
                dp[j] = Math.max(dp[j], dp[j - 1] + stations[i][1]);
            }
        }
    }

    for (let i = 0; i <= stations.length; i++) {
        if (dp[i] >= target) {
            return i;
        }
    }

    return -1;
};
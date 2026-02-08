var countRoutes = function(locations, start, finish, fuel) {
    const MOD = 1e9 + 7;
    const n = locations.length;
    const dp = new Array(n).fill().map(() => new Array(fuel + 1).fill(0));

    for (let f = 0; f <= fuel; f++) {
        dp[finish][f] = 1;
    }

    for (let f = 0; f <= fuel; f++) {
        for (let city = 0; city < n; city++) {
            for (let nextCity = 0; nextCity < n; nextCity++) {
                if (nextCity !== city) {
                    const neededFuel = Math.abs(locations[city] - locations[nextCity]);
                    if (f >= neededFuel) {
                        dp[city][f] = (dp[city][f] + dp[nextCity][f - neededFuel]) % MOD;
                    }
                }
            }
        }
    }

    return dp[start][fuel];
};
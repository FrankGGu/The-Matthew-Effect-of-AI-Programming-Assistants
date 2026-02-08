var countRoutes = function(locations, start, finish, fuel) {
    const n = locations.length;
    const MOD = 10**9 + 7;
    const dp = Array(n).fill(null).map(() => Array(fuel + 1).fill(0));

    dp[start][fuel] = 1;

    for (let f = fuel; f >= 0; f--) {
        for (let i = 0; i < n; i++) {
            if (dp[i][f] > 0) {
                for (let j = 0; j < n; j++) {
                    if (i !== j) {
                        const cost = Math.abs(locations[i] - locations[j]);
                        if (f >= cost) {
                            dp[j][f - cost] = (dp[j][f - cost] + dp[i][f]) % MOD;
                        }
                    }
                }
            }
        }
    }

    let ans = 0;
    for (let f = 0; f <= fuel; f++) {
        ans = (ans + dp[finish][f]) % MOD;
    }

    return ans;
};
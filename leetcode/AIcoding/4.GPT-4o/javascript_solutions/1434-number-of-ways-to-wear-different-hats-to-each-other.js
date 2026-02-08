var numberOfWays = function(hats) {
    const mod = 1e9 + 7;
    const n = hats.length;
    const maxHat = 40;
    const dp = Array(1 << n).fill(0);
    dp[0] = 1;

    for (let hat = 1; hat <= maxHat; hat++) {
        let temp = dp.slice();
        for (let person = 0; person < n; person++) {
            if (hats[person].includes(hat)) {
                for (let mask = 0; mask < (1 << n); mask++) {
                    if ((mask & (1 << person)) === 0) {
                        temp[mask | (1 << person)] = (temp[mask | (1 << person)] + dp[mask]) % mod;
                    }
                }
            }
        }
        dp = temp;
    }

    return dp[(1 << n) - 1];
};
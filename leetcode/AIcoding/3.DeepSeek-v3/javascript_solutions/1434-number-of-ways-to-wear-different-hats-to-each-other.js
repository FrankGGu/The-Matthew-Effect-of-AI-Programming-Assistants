const numberWays = (hats) => {
    const MOD = 1e9 + 7;
    const n = hats.length;
    const maxHat = Math.max(...hats.flat());
    const hatToPeople = Array.from({ length: maxHat + 1 }, () => []);

    for (let i = 0; i < n; i++) {
        for (const hat of hats[i]) {
            hatToPeople[hat].push(i);
        }
    }

    const dp = Array.from({ length: maxHat + 1 }, () => Array(1 << n).fill(0));
    dp[0][0] = 1;

    for (let hat = 1; hat <= maxHat; hat++) {
        for (let mask = 0; mask < (1 << n); mask++) {
            dp[hat][mask] = dp[hat - 1][mask];
        }

        for (const person of hatToPeople[hat]) {
            for (let mask = 0; mask < (1 << n); mask++) {
                if ((mask & (1 << person)) === 0) {
                    const newMask = mask | (1 << person);
                    dp[hat][newMask] = (dp[hat][newMask] + dp[hat - 1][mask]) % MOD;
                }
            }
        }
    }

    return dp[maxHat][(1 << n) - 1];
};
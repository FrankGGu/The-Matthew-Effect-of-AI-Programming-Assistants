function numberWays(hatsToPersons) {
    const n = hatsToPersons.length;
    const dp = new Array(1 << n).fill(0);
    dp[0] = 1;

    for (let i = 0; i < hatsToPersons.length; i++) {
        const persons = hatsToPersons[i];
        for (let mask = 0; mask < (1 << n); mask++) {
            if (dp[mask] === 0) continue;
            for (const p of persons) {
                if (!(mask & (1 << p))) {
                    dp[mask | (1 << p)] += dp[mask];
                }
            }
        }
    }

    return dp[(1 << n) - 1];
}
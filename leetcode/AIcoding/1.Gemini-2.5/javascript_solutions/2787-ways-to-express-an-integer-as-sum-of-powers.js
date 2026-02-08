var numberOfWays = function(n, x) {
    const MOD = 10 ** 9 + 7;

    const dp = new Array(n + 1).fill(0);
    dp[0] = 1;

    const powers = [];
    for (let k = 1; ; k++) {
        const power = Math.pow(k, x);

        if (power > n) {
            break;
        }

        powers.push(power);
    }

    for (const power of powers) {
        for (let j = n; j >= power; j--) {
            dp[j] = (dp[j] + dp[j - power]) % MOD;
        }
    }

    return dp[n];
};
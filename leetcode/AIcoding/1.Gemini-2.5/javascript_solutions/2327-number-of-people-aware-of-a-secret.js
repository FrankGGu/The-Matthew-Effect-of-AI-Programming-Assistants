var peopleAwareOfSecret = function(n, delay, forget) {
    const MOD = 10 ** 9 + 7;
    const dp = new Array(n + 1).fill(0);

    dp[1] = 1;

    let sharing = 0;
    let totalAware = 0;

    for (let i = 1; i <= n; i++) {
        if (i - delay >= 1) {
            sharing = (sharing + dp[i - delay]) % MOD;
        }

        if (i - forget >= 1) {
            sharing = (sharing - dp[i - forget] + MOD) % MOD;
        }

        if (i > 1) {
            dp[i] = sharing;
        }

        totalAware = (totalAware + dp[i]) % MOD;

        if (i - forget >= 1) {
            totalAware = (totalAware - dp[i - forget] + MOD) % MOD;
        }
    }

    return totalAware;
};
var keyboard = function(k, n) {
    const MOD = 1e9 + 7;
    const dp = new Array(n + 1).fill(0).map(() => new Array(k + 1).fill(0));
    dp[0][0] = 1;

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= k; j++) {
            for (let l = 0; l <= Math.min(i, j); l++) {
                dp[i][j] = (dp[i][j] + dp[i - l][j - 1] * comb(i, l)) % MOD;
            }
        }
    }

    let res = 0;
    for (let j = 1; j <= k; j++) {
        res = (res + dp[n][j]) % MOD;
    }
    return res;

    function comb(n, k) {
        if (k > n || k < 0) return 0;
        if (k === 0 || k === n) return 1;
        k = Math.min(k, n - k);
        let res = 1;
        for (let i = 1; i <= k; i++) {
            res = res * (n - k + i) / i;
        }
        return res % MOD;
    }
};
function paintingPlan(n, m, k) {
    const MOD = 1e9 + 7;
    const dp = Array.from({ length: k + 1 }, () => Array(m + 1).fill(0));
    dp[0][0] = 1;

    for (let i = 1; i <= k; i++) {
        for (let j = 1; j <= m; j++) {
            dp[i][j] = dp[i][j - 1];
            if (j >= 2) {
                dp[i][j] = (dp[i][j] + dp[i - 1][j - 2] * (j - 1)) % MOD;
            }
        }
    }

    let result = 0;
    for (let i = 0; i <= k; i++) {
        result = (result + dp[i][m] * combination(k, i)) % MOD;
    }
    return result;
}

function combination(n, k) {
    if (k > n) return 0;
    let res = 1;
    for (let i = 0; i < k; i++) {
        res = (res * (n - i)) % (1e9 + 7);
        res = (res * modInverse(i + 1)) % (1e9 + 7);
    }
    return res;
}

function modInverse(a) {
    let m = 1e9 + 7, m0 = m, y = 0, x = 1;
    if (m === 1) return 0;
    while (a > 1) {
        let q = Math.floor(a / m);
        let t = m;
        m = a % m;
        a = t;
        t = y;
        y = x - q * y;
        x = t;
    }
    return x < 0 ? x + m0 : x;
}
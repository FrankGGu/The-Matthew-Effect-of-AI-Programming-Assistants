var countPartitions = function(n, k) {
    const MOD = 1e9 + 7;
    const totalSum = n * (n + 1) / 2;
    if (totalSum < k) return 0;

    const dp = new Array(totalSum + 1).fill(0);
    dp[0] = 1;

    for (let i = 1; i <= n; i++) {
        for (let j = totalSum; j >= i; j--) {
            dp[j] = (dp[j] + dp[j - i]) % MOD;
        }
    }

    let result = 0;
    for (let s = k; s <= totalSum; s++) {
        result = (result + dp[s]) % MOD;
    }

    return (result * modInverse(2, MOD)) % MOD;
};

function modInverse(a, m) {
    let m0 = m, y = 0, x = 1;
    if (m === 1) return 0;
    while (a > 1) {
        let q = Math.floor(a / m);
        let t = m;
        m = a % m; a = t; 
        t = y;
        y = x - q * y; x = t;
    }
    if (x < 0) x += m0;
    return x;
}
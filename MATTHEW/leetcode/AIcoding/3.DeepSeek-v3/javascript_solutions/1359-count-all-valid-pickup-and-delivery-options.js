var countOrders = function(n) {
    let res = 1;
    const MOD = 1e9 + 7;
    for (let i = 1; i <= n; i++) {
        res = res * i % MOD;
        res = res * (2 * i - 1) % MOD;
    }
    return res;
};
var countOrders = function(n) {
    const MOD = 1e9 + 7;
    let res = 1;

    for (let i = 1; i <= n; i++) {
        res = (res * (2 * i) * (2 * i - 1)) % MOD;
    }

    return res;
};
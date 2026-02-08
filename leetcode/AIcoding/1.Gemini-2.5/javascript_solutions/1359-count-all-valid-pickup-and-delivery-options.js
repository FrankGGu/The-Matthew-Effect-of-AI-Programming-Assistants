var countOrders = function(n) {
    const MOD = 1000000007;
    let ans = 1;

    for (let i = 1; i <= n; i++) {
        ans = (ans * i) % MOD;
        ans = (ans * (2 * i - 1)) % MOD;
    }

    return ans;
};
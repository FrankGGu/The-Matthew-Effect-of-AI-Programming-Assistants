var countOrders = function(n) {
    let mod = 10**9 + 7;
    let ans = 1;
    for (let i = 1; i <= n; i++) {
        ans = (ans * i) % mod;
        ans = (ans * (2 * i - 1)) % mod;
    }
    return ans;
};
var peopleAwareOfSecret = function(n, delay, forget) {
    const MOD = 1e9 + 7;
    let dp = new Array(n + 1).fill(0);
    dp[1] = 1;
    let total = 0;

    for (let i = 2; i <= n; i++) {
        let newPeople = 0;
        for (let j = Math.max(1, i - forget + 1); j <= i - delay; j++) {
            newPeople = (newPeople + dp[j]) % MOD;
        }
        dp[i] = newPeople;
    }

    for (let i = Math.max(1, n - forget + 1); i <= n; i++) {
        total = (total + dp[i]) % MOD;
    }

    return total;
};
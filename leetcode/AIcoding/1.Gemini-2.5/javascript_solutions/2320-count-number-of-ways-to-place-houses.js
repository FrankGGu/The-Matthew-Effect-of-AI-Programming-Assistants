var countHousePlacements = function(n) {
    const MOD = 10**9 + 7;

    if (n === 1) {
        return 4;
    }

    let prev2 = 1;
    let prev1 = 2;

    for (let i = 2; i <= n; i++) {
        let current = (prev1 + prev2) % MOD;
        prev2 = prev1;
        prev1 = current;
    }

    return (prev1 * prev1) % MOD;
};
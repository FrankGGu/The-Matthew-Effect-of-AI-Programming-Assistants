var monkeyMove = function(n) {
    const MOD = 1e9 + 7;
    let res = 1;
    let base = 2;
    while (n > 0) {
        if (n % 2 === 1) {
            res = (res * base) % MOD;
        }
        base = (base * base) % MOD;
        n = Math.floor(n / 2);
    }
    return (res - 2 + MOD) % MOD;
};
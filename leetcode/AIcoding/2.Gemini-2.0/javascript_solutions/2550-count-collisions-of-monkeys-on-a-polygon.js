var monkeyMove = function(n) {
    const MOD = 10**9 + 7;
    let result = 1;
    let base = 2;
    let exponent = n;

    while (exponent > 0) {
        if (exponent % 2 === 1) {
            result = (result * base) % MOD;
        }
        base = (base * base) % MOD;
        exponent = Math.floor(exponent / 2);
    }

    return (result - 2 + MOD) % MOD;
};
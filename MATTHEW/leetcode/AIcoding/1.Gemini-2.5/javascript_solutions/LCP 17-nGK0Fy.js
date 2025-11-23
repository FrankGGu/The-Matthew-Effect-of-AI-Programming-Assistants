var robot = function(n) {
    const MOD = 10**9 + 7;
    let result = 1;
    let base = 2;

    while (n > 0) {
        if (n % 2 === 1) {
            result = (result * base) % MOD;
        }
        base = (base * base) % MOD;
        n = Math.floor(n / 2);
    }

    return result;
};
var minNonZeroProduct = function(p) {
    const MOD = 10**9 + 7;
    let maxVal = (1 << p) - 1;
    let count = (1 << (p - 1));
    let product = 1;
    let base = maxVal - 1;

    while (count > 0) {
        if (count % 2 === 1) {
            product = (product * base) % MOD;
        }
        base = (base * base) % MOD;
        count = Math.floor(count / 2);
    }

    return (product * maxVal) % MOD;
};
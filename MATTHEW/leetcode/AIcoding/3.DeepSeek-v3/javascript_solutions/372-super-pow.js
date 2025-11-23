var superPow = function(a, b) {
    const MOD = 1337;
    if (b.length === 0) return 1;
    const last = b.pop();
    const part1 = powMod(a, last);
    const part2 = powMod(superPow(a, b), 10);
    return (part1 * part2) % MOD;
};

function powMod(a, k, mod = 1337) {
    a %= mod;
    let result = 1;
    for (let i = 0; i < k; i++) {
        result = (result * a) % mod;
    }
    return result;
}
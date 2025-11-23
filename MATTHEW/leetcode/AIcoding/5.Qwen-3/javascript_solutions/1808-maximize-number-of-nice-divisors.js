function maxNiceDivisors(n) {
    const MOD = 1000000007;
    if (n === 1) return 1;
    if (n === 2) return 2;
    let result = 1;
    let exponent = n;
    while (exponent > 0) {
        if (exponent % 2 === 1) {
            result = (result * 2) % MOD;
        }
        exponent = Math.floor(exponent / 2);
        if (exponent > 0) {
            result = (result * result) % MOD;
        }
    }
    return result;
}
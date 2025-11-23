function numberOfString(n, k) {
    const MOD = 10 ** 9 + 7;
    const pow = (base, exponent) => {
        let result = 1;
        while (exponent > 0) {
            if (exponent % 2 === 1) result = (result * base) % MOD;
            base = (base * base) % MOD;
            exponent = Math.floor(exponent / 2);
        }
        return result;
    };
    const total = pow(k, n);
    const noSubstring = pow(k - 1, n);
    return (total - noSubstring + MOD) % MOD;
}
var superPow = function(a, b) {
    const MOD = 1337;

    function pow(base, exponent) {
        let res = 1;
        base %= MOD;
        while (exponent > 0) {
            if (exponent % 2 === 1) res = (res * base) % MOD;
            base = (base * base) % MOD;
            exponent = Math.floor(exponent / 2);
        }
        return res;
    }

    let res = 1;
    for (let digit of b) {
        res = (pow(res, 10) * pow(a, digit)) % MOD;
    }

    return res;
};
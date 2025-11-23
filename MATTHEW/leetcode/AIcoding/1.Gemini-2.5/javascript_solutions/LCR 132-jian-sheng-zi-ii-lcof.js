var cuttingRope = function(n) {
    const MOD = 1000000007;

    function power(base, exp) {
        let res = 1;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 === 1) {
                res = (res * base) % MOD;
            }
            base = (base * base) % MOD;
            exp = Math.floor(exp / 2);
        }
        return res;
    }

    if (n <= 3) {
        return n - 1;
    }

    let quotient = Math.floor(n / 3);
    let remainder = n % 3;

    if (remainder === 0) {
        return power(3, quotient);
    } else if (remainder === 1) {
        return (power(3, quotient - 1) * 4) % MOD;
    } else { // remainder === 2
        return (power(3, quotient) * 2) % MOD;
    }
};
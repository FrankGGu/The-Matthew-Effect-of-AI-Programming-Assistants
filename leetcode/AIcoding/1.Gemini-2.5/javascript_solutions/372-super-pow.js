var superPow = function(a, b) {
    const MOD = 1337;

    const powMod = (base, exp) => {
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
    };

    const calculate = (a, bArray) => {
        if (bArray.length === 0) {
            return 1;
        }

        const lastDigit = bArray.pop();

        const part1 = powMod(calculate(a, bArray), 10);
        const part2 = powMod(a, lastDigit);

        return (part1 * part2) % MOD;
    };

    return calculate(a, b);
};
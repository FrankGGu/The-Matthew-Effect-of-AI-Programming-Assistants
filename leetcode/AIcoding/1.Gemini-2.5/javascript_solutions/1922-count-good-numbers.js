var countGoodNumbers = function(n) {
    const MOD = 1000000007;

    const power = (base, exp) => {
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

    const numEvenIndices = Math.ceil(n / 2);
    const numOddIndices = Math.floor(n / 2);

    const countForEvenPositions = power(5, numEvenIndices);
    const countForOddPositions = power(4, numOddIndices);

    return (countForEvenPositions * countForOddPositions) % MOD;
};
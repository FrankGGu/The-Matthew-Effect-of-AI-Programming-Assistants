var monkeyCollision = function(n) {
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

    let totalConfigurations = power(2, n);
    let collisionConfigurations = (totalConfigurations - 2 + MOD) % MOD;

    return collisionConfigurations;
};
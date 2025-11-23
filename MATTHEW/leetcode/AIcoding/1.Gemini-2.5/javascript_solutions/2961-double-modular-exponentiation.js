var getGoodIndices = function(variables, target) {
    const pow = (base, exp, mod) => {
        let res = 1;
        base %= mod;
        while (exp > 0) {
            if (exp % 2 === 1) {
                res = (res * base) % mod;
            }
            base = (base * base) % mod;
            exp = Math.floor(exp / 2);
        }
        return res;
    };

    const goodIndices = [];
    for (let i = 0; i < variables.length; i++) {
        const [a, b, c, m] = variables[i];

        const firstModExp = pow(a, b, 10);
        const finalResult = pow(firstModExp, c, m);

        if (finalResult === target) {
            goodIndices.push(i);
        }
    }

    return goodIndices;
};
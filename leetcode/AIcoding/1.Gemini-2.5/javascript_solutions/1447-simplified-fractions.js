var simplifiedFractions = function(n) {
    const result = [];

    const gcd = (a, b) => {
        while (b !== 0) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    };

    for (let denominator = 2; denominator <= n; denominator++) {
        for (let numerator = 1; numerator < denominator; numerator++) {
            if (gcd(numerator, denominator) === 1) {
                result.push(`${numerator}/${denominator}`);
            }
        }
    }

    return result;
};
var simplifiedFractions = function(n) {
    let result = [];
    for (let denominator = 2; denominator <= n; denominator++) {
        for (let numerator = 1; numerator < denominator; numerator++) {
            if (gcd(numerator, denominator) === 1) {
                result.push(`${numerator}/${denominator}`);
            }
        }
    }
    return result;
};

function gcd(a, b) {
    while (b) {
        [a, b] = [b, a % b];
    }
    return a;
}
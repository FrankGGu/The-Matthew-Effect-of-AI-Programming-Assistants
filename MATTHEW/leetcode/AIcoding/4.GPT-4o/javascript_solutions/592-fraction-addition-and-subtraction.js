function fractionAddition(expression) {
    let numerator = 0, denominator = 1;
    let fractions = expression.match(/[+-]?\d+\/\d+/g);

    for (let fraction of fractions) {
        let [num, denom] = fraction.split('/').map(Number);
        numerator = numerator * denom + num * denominator;
        denominator *= denom;
        let gcd = function gcd(a, b) {
            return b === 0 ? a : gcd(b, a % b);
        }(Math.abs(numerator), Math.abs(denominator));
        numerator /= gcd;
        denominator /= gcd;
    }

    return `${numerator}/${denominator}`;
}
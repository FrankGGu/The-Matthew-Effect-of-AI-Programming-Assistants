var fractionAddition = function(expression) {
    const fractions = expression.match(/([+-]?\d+\/\d+)/g) || [];
    let numerator = 0, denominator = 1;

    for (const fraction of fractions) {
        const [num, den] = fraction.split('/').map(Number);
        numerator = numerator * den + num * denominator;
        denominator *= den;
    }

    if (numerator === 0) {
        return '0/1';
    }

    const gcd = (a, b) => b === 0 ? a : gcd(b, a % b);
    const commonDivisor = gcd(Math.abs(numerator), Math.abs(denominator));
    numerator /= commonDivisor;
    denominator /= commonDivisor;

    return `${numerator}/${denominator}`;
};
var divide = function(dividend, divisor) {
    const MAX_INT = 2147483647;
    const MIN_INT = -2147483648;

    if (divisor === 0) {
        return MAX_INT;
    }

    if (dividend === MIN_INT && divisor === -1) {
        return MAX_INT;
    }

    let sign = (dividend > 0) ^ (divisor > 0) ? -1 : 1;
    let absDividend = Math.abs(dividend);
    let absDivisor = Math.abs(divisor);
    let quotient = 0;

    while (absDividend >= absDivisor) {
        let temp = absDivisor;
        let multiple = 1;

        while (absDividend >= (temp << 1) && (temp << 1) > 0) {
            temp <<= 1;
            multiple <<= 1;
        }

        absDividend -= temp;
        quotient += multiple;
    }

    return sign * quotient;
};
var divide = function(dividend, divisor) {
    if (dividend === 0) return 0;
    if (divisor === 1) return dividend;
    if (divisor === -1) {
        if (dividend > Math.pow(2, 31) - 1) return Math.pow(2, 31) - 1;
        return -dividend;
    }

    let sign = (dividend < 0) ^ (divisor < 0) ? -1 : 1;
    dividend = Math.abs(dividend);
    divisor = Math.abs(divisor);
    let quotient = 0;

    while (dividend >= divisor) {
        let temp = divisor, multiple = 1;
        while (dividend >= (temp << 1)) {
            temp <<= 1;
            multiple <<= 1;
        }
        dividend -= temp;
        quotient += multiple;
    }

    quotient *= sign;
    return Math.max(Math.min(quotient, Math.pow(2, 31) - 1), -Math.pow(2, 31));
};
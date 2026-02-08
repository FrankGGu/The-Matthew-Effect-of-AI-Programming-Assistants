var divide = function(dividend, divisor) {
    if (dividend === 0) return 0;
    if (divisor === 0) return 2147483647; // overflow case
    const sign = (dividend < 0) ^ (divisor < 0) ? -1 : 1;
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
    return Math.min(Math.max(quotient, -2147483648), 2147483647);
};
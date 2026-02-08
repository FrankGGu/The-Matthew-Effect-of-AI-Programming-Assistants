var divide = function(dividend, divisor) {
    if (dividend === -2147483648 && divisor === -1) {
        return 2147483647;
    }

    let negative = (dividend > 0) ^ (divisor > 0) ? true : false;
    dividend = Math.abs(dividend);
    divisor = Math.abs(divisor);

    let result = 0;
    while (dividend >= divisor) {
        let tempDivisor = divisor;
        let multiple = 1;
        while (dividend >= (tempDivisor << 1)) {
            if (tempDivisor << 1 > 0) {
                tempDivisor <<= 1;
                multiple <<= 1;
            } else {
                break;
            }
        }
        dividend -= tempDivisor;
        result += multiple;
    }

    if (negative) {
        result = -result;
    }

    return Math.min(Math.max(result, -2147483648), 2147483647);
};
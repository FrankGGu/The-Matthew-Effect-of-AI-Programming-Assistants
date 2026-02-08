var divide = function(dividend, divisor) {
    const MAX_INT = 2147483647;
    const MIN_INT = -2147483648;

    if (divisor === 0) {
        return MAX_INT;
    }

    if (dividend === 0) {
        return 0;
    }

    if (dividend === MIN_INT && divisor === -1) {
        return MAX_INT;
    }

    let sign = (dividend > 0) ^ (divisor > 0) ? -1 : 1;

    let dvd = Math.abs(dividend);
    let dvs = Math.abs(divisor);

    let quotient = 0;
    while (dvd >= dvs) {
        let temp = dvs;
        let multiple = 1;
        while (dvd >= (temp << 1) && (temp << 1) > 0) {
            temp <<= 1;
            multiple <<= 1;
        }
        dvd -= temp;
        quotient += multiple;
    }

    return sign * quotient;
};
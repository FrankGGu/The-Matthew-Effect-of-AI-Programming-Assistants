var divide = function(dividend, divisor) {
    const MAX_INT = 2147483647;
    const MIN_INT = -2147483648;

    if (dividend === MIN_INT && divisor === -1) {
        return MAX_INT;
    }

    let isNegative = (dividend < 0) ^ (divisor < 0);

    let dvd = dividend > 0 ? -dividend : dividend;
    let dvs = divisor > 0 ? -divisor : divisor;

    let quotient = 0;

    while (dvd <= dvs) {
        let temp_dvs = dvs;
        let multiple = 1;

        while (dvd <= (temp_dvs << 1) && (temp_dvs << 1) < 0) {
            temp_dvs <<= 1;
            multiple <<= 1;
        }

        dvd -= temp_dvs;
        quotient += multiple;
    }

    return isNegative ? -quotient : quotient;
};
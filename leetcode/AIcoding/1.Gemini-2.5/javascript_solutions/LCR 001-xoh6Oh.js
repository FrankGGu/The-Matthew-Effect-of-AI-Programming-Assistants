var divide = function(dividend, divisor) {
    const MAX_INT = 2147483647;
    const MIN_INT = -2147483648;

    if (dividend === MIN_INT && divisor === -1) {
        return MAX_INT;
    }

    let sign = 1;
    if ((dividend < 0 && divisor > 0) || (dividend > 0 && divisor < 0)) {
        sign = -1;
    }

    let dvd = dividend;
    let dvs = divisor;

    if (dvd > 0) {
        dvd = -dvd;
    }
    if (dvs > 0) {
        dvs = -dvs;
    }

    let quotient = 0;

    while (dvd <= dvs) {
        let tempDvs = dvs;
        let multiple = 1;
        while (dvd <= (tempDvs << 1) && (tempDvs << 1) < 0) {
            tempDvs <<= 1;
            multiple <<= 1;
        }
        dvd -= tempDvs;
        quotient += multiple;
    }

    return sign * quotient;
};
var fractionToDecimal = function(numerator, denominator) {
    if (numerator === 0) {
        return "0";
    }

    let sign = (numerator < 0) ^ (denominator < 0) ? "-" : "";
    let num = Math.abs(numerator);
    let den = Math.abs(denominator);

    let integerPart = Math.floor(num / den);
    let remainder = num % den;

    if (remainder === 0) {
        return sign + integerPart;
    }

    let decimalPart = "";
    let remainderMap = new Map();

    while (remainder !== 0) {
        if (remainderMap.has(remainder)) {
            let index = remainderMap.get(remainder);
            decimalPart = decimalPart.substring(0, index) + "(" + decimalPart.substring(index) + ")";
            break;
        }

        remainderMap.set(remainder, decimalPart.length);
        remainder *= 10;
        decimalPart += Math.floor(remainder / den);
        remainder %= den;
    }

    return sign + integerPart + "." + decimalPart;
};
function fractionToDecimal(numerator, denominator) {
    if (numerator === 0) return "0";

    let result = "";

    if ((numerator < 0) ^ (denominator < 0)) {
        result += "-";
    }

    let num = Math.abs(numerator);
    let den = Math.abs(denominator);

    result += Math.floor(num / den).toString();

    let remainder = num % den;

    if (remainder === 0) {
        return result;
    }

    result += ".";

    let map = new Map();

    while (remainder !== 0) {
        if (map.has(remainder)) {
            let index = map.get(remainder);
            return result.substring(0, index) + "(" + result.substring(index) + ")";
        }

        map.set(remainder, result.length);
        remainder *= 10;
        result += Math.floor(remainder / den).toString();
        remainder %= den;
    }

    return result;
}
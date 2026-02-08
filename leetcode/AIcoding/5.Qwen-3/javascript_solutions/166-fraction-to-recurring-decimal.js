function fractionToDecimal(numerator, denominator) {
    if (numerator === 0) return "0";

    let result = "";
    if ((numerator < 0) ^ (denominator < 0)) {
        result += "-";
    }

    let n = Math.abs(numerator);
    let d = Math.abs(denominator);

    result += Math.floor(n / d).toString();

    let remainder = n % d;
    if (remainder === 0) {
        return result;
    }

    result += ".";

    let map = new Map();
    while (remainder !== 0) {
        if (map.has(remainder)) {
            let index = map.get(remainder);
            result = result.substring(0, index) + "(" + result.substring(index) + ")";
            return result;
        }
        map.set(remainder, result.length);
        remainder *= 10;
        result += Math.floor(remainder / d).toString();
        remainder %= d;
    }

    return result;
}
var fractionToDecimal = function(numerator, denominator) {
    if (numerator === 0) return "0";
    let result = "";
    if (Math.sign(numerator) !== Math.sign(denominator)) result += "-";
    numerator = Math.abs(numerator);
    denominator = Math.abs(denominator);

    result += Math.floor(numerator / denominator);
    numerator %= denominator;
    if (numerator === 0) return result;

    result += ".";
    const map = new Map();
    while (numerator !== 0) {
        if (map.has(numerator)) {
            const index = map.get(numerator);
            result = result.slice(0, index) + "(" + result.slice(index) + ")";
            return result;
        }
        map.set(numerator, result.length);
        numerator *= 10;
        result += Math.floor(numerator / denominator);
        numerator %= denominator;
    }
    return result;
};
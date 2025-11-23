var fractionToDecimal = function(numerator, denominator) {
    if (numerator === 0) {
        return "0";
    }

    let result = [];

    if ((numerator < 0) !== (denominator < 0)) {
        result.push("-");
    }

    let absNumerator = Math.abs(numerator);
    let absDenominator = Math.abs(denominator);

    result.push(Math.floor(absNumerator / absDenominator));

    let remainder = absNumerator % absDenominator;

    if (remainder === 0) {
        return result.join("");
    }

    result.push(".");

    let remainderMap = new Map();
    let decimalPart = [];
    let index = 0;

    while (remainder !== 0) {
        if (remainderMap.has(remainder)) {
            let insertPos = remainderMap.get(remainder);
            decimalPart.splice(insertPos, 0, "(");
            decimalPart.push(")");
            break;
        }

        remainderMap.set(remainder, index);

        remainder *= 10;
        decimalPart.push(Math.floor(remainder / absDenominator));
        remainder %= absDenominator;
        index++;
    }

    return result.concat(decimalPart).join("");
};
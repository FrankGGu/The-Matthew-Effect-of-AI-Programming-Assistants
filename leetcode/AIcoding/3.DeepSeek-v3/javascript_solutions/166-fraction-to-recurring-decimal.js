var fractionToDecimal = function(numerator, denominator) {
    if (numerator === 0) return "0";

    let res = [];
    if ((numerator < 0) ^ (denominator < 0)) {
        res.push("-");
    }

    let num = Math.abs(numerator);
    let den = Math.abs(denominator);

    res.push(Math.floor(num / den).toString());
    let remainder = num % den;
    if (remainder === 0) {
        return res.join("");
    }

    res.push(".");
    let map = new Map();
    while (remainder !== 0) {
        if (map.has(remainder)) {
            res.splice(map.get(remainder), 0, "(");
            res.push(")");
            break;
        }
        map.set(remainder, res.length);
        remainder *= 10;
        res.push(Math.floor(remainder / den).toString());
        remainder = remainder % den;
    }

    return res.join("");
};
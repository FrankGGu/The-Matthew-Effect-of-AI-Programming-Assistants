var isRationalEqual = function(s, t) {
    const parse = (str) => {
        if (!str.includes('(')) {
            return parseFloat(str);
        }
        const parts = str.split('.');
        const integerPart = parts[0];
        const decimalPart = parts[1];
        const leftParen = decimalPart.indexOf('(');
        const nonRepeating = decimalPart.substring(0, leftParen);
        const repeating = decimalPart.substring(leftParen + 1, decimalPart.length - 1);
        const fullDecimal = nonRepeating + repeating.repeat(20);
        const num = parseFloat(integerPart + '.' + fullDecimal.substring(0, 20));
        return num;
    };
    const num1 = parse(s);
    const num2 = parse(t);
    return Math.abs(num1 - num2) < 1e-9;
};
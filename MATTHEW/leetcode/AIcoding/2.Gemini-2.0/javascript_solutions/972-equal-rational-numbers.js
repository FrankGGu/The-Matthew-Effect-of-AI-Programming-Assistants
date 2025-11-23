var isRationalEqual = function(s, t) {
    function toFloat(str) {
        if (str.indexOf('(') === -1) {
            return parseFloat(str);
        }

        let integerPart = '';
        let decimalPart = '';
        let repeatingPart = '';

        let dotIndex = str.indexOf('.');
        if (dotIndex === -1) {
            integerPart = str;
        } else {
            integerPart = str.substring(0, dotIndex);
            let openParenIndex = str.indexOf('(');
            if (openParenIndex === -1) {
                decimalPart = str.substring(dotIndex + 1);
            } else {
                decimalPart = str.substring(dotIndex + 1, openParenIndex);
                repeatingPart = str.substring(openParenIndex + 1, str.length - 1);
            }
        }

        let numStr = integerPart + '.';
        numStr += decimalPart;
        for (let i = 0; i < 20; i++) {
            numStr += repeatingPart;
        }

        return parseFloat(numStr);
    }

    const floatS = toFloat(s);
    const floatT = toFloat(t);

    return Math.abs(floatS - floatT) < 1e-12;
};
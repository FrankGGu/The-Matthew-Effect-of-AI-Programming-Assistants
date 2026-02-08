var atMostNGivenDigitSet = function(digits, n) {
    const strN = n.toString();
    const lenN = strN.length;
    const lenD = digits.length;
    let count = 0;

    for (let i = 1; i < lenN; i++) {
        count += Math.pow(lenD, i);
    }

    for (let i = 0; i < lenN; i++) {
        let hasSamePrefix = false;
        for (const digit of digits) {
            if (digit < strN[i]) {
                count += Math.pow(lenD, lenN - i - 1);
            } else if (digit === strN[i]) {
                hasSamePrefix = true;
                break;
            }
        }
        if (!hasSamePrefix) {
            break;
        }
    }

    return count + 1;
};
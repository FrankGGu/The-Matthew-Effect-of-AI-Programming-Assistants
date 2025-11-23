var isNumber = function(s) {
    s = s.trim();

    let seenDigit = false;
    let seenDot = false;
    let seenE = false;

    for (let i = 0; i < s.length; i++) {
        const char = s[i];

        if (char >= '0' && char <= '9') {
            seenDigit = true;
        } else if (char === '.') {
            if (seenDot || seenE) {
                return false;
            }
            seenDot = true;
        } else if (char === 'e' || char === 'E') {
            if (seenE || !seenDigit) {
                return false;
            }
            seenE = true;
            seenDigit = false; // Reset seenDigit for the exponent part
        } else if (char === '+' || char === '-') {
            if (i !== 0 && s[i - 1] !== 'e' && s[i - 1] !== 'E') {
                return false;
            }
        } else {
            return false;
        }
    }

    return seenDigit;
};
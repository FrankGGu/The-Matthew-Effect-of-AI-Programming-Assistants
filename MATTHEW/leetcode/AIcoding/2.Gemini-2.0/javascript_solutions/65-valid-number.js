var isNumber = function(s) {
    s = s.trim();
    let hasDot = false;
    let hasE = false;
    let hasDigit = false;

    for (let i = 0; i < s.length; i++) {
        const char = s[i];

        if (char >= '0' && char <= '9') {
            hasDigit = true;
        } else if (char === '.') {
            if (hasDot || hasE) {
                return false;
            }
            hasDot = true;
        } else if (char === 'e' || char === 'E') {
            if (hasE || !hasDigit) {
                return false;
            }
            hasE = true;
            hasDigit = false;
        } else if (char === '+' || char === '-') {
            if (i !== 0 && s[i - 1] !== 'e' && s[i - 1] !== 'E') {
                return false;
            }
        } else {
            return false;
        }
    }

    return hasDigit;
};
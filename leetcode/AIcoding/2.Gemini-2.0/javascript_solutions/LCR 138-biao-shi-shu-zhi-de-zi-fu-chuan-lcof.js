var isNumber = function(s) {
    s = s.trim();
    let hasE = false;
    let hasDot = false;
    let hasNum = false;

    for (let i = 0; i < s.length; i++) {
        const char = s[i];

        if (char >= '0' && char <= '9') {
            hasNum = true;
        } else if (char === '.') {
            if (hasE || hasDot) {
                return false;
            }
            hasDot = true;
        } else if (char === 'e' || char === 'E') {
            if (hasE || !hasNum) {
                return false;
            }
            hasE = true;
            hasNum = false;
        } else if (char === '+' || char === '-') {
            if (i !== 0 && s[i - 1] !== 'e' && s[i - 1] !== 'E') {
                return false;
            }
        } else {
            return false;
        }
    }

    return hasNum;
};
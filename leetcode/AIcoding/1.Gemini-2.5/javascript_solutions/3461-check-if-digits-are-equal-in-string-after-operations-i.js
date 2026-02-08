var areDigitsEqual = function(s) {
    for (let i = 0; i < s.length; i += 2) {
        const charValue = s.charCodeAt(i) - 'a'.charCodeAt(0);
        const digitValue = parseInt(s[i + 1]);
        if (charValue !== digitValue) {
            return false;
        }
    }
    return true;
};
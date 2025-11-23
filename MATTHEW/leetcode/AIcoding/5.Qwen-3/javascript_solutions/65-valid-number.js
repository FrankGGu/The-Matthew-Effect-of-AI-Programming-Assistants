function isNumber(s) {
    s = s.trim();
    const eIndex = s.indexOf('e');
    if (eIndex === -1) {
        return isInteger(s) || isDecimal(s);
    } else {
        return isInteger(s.substring(0, eIndex)) || isDecimal(s.substring(0, eIndex)) && isInteger(s.substring(eIndex + 1));
    }
}

function isInteger(s) {
    if (s.length === 0) return false;
    if (s[0] === '+' || s[0] === '-') s = s.substring(1);
    return s.length > 0 && /^[\d]+$/.test(s);
}

function isDecimal(s) {
    if (s.length === 0) return false;
    if (s[0] === '+' || s[0] === '-') s = s.substring(1);
    const dotIndex = s.indexOf('.');
    if (dotIndex === -1) return false;
    const left = s.substring(0, dotIndex);
    const right = s.substring(dotIndex + 1);
    return (left === '' || /^[\d]+$/.test(left)) && (right === '' || /^[\d]+$/.test(right));
}
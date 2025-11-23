var removeTrailingZeros = function(s) {
    let i = s.length - 1;
    while (i >= 0 && s[i] === '0') {
        i--;
    }
    return s.substring(0, i + 1);
};
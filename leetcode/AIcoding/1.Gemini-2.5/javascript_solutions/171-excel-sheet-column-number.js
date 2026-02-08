var titleToNumber = function(s) {
    let result = 0;
    for (let i = 0; i < s.length; i++) {
        const charValue = s.charCodeAt(i) - 'A'.charCodeAt(0) + 1;
        result = result * 26 + charValue;
    }
    return result;
};
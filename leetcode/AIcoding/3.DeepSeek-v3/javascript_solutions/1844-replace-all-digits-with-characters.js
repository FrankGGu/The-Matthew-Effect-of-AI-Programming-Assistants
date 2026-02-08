var replaceDigits = function(s) {
    let result = [];
    for (let i = 0; i < s.length; i++) {
        if (i % 2 === 0) {
            result.push(s[i]);
        } else {
            let prevChar = s[i - 1];
            let shift = parseInt(s[i]);
            let newChar = String.fromCharCode(prevChar.charCodeAt(0) + shift);
            result.push(newChar);
        }
    }
    return result.join('');
};
var replaceDigits = function(s) {
    const chars = s.split('');
    for (let i = 1; i < chars.length; i += 2) {
        const prevChar = chars[i - 1];
        const digit = parseInt(chars[i]);
        const newCharCode = prevChar.charCodeAt(0) + digit;
        chars[i] = String.fromCharCode(newCharCode);
    }
    return chars.join('');
};
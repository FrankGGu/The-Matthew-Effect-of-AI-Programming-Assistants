var replaceDigits = function(s) {
    let result = "";
    for (let i = 0; i < s.length; i++) {
        if (i % 2 === 0) {
            result += s[i];
        } else {
            result += String.fromCharCode(s.charCodeAt(i - 1) + parseInt(s[i]));
        }
    }
    return result;
};
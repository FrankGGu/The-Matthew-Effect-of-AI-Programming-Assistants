var freqAlphabets = function(s) {
    let result = '';
    for (let i = s.length - 1; i >= 0; i--) {
        if (s[i] === '#') {
            let num = s[i - 2] + s[i - 1];
            result = String.fromCharCode(Number(num) + 96) + result;
            i -= 2;
        } else {
            result = String.fromCharCode(Number(s[i]) + 96) + result;
        }
    }
    return result;
};
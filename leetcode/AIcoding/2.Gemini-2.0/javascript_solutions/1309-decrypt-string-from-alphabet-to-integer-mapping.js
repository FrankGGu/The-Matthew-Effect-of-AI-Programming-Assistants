var freqAlphabets = function(s) {
    let res = "";
    for (let i = 0; i < s.length; i++) {
        if (i + 2 < s.length && s[i + 2] === '#') {
            res += String.fromCharCode(parseInt(s.substring(i, i + 2)) + 96);
            i += 2;
        } else {
            res += String.fromCharCode(parseInt(s[i]) + 96);
        }
    }
    return res;
};
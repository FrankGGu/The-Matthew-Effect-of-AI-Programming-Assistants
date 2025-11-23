function freqAlphabets(s) {
    let result = '';
    let i = 0;
    while (i < s.length) {
        if (i + 2 < s.length && s[i + 2] === '#') {
            result += String.fromCharCode(96 + parseInt(s.substring(i, i + 2)));
            i += 3;
        } else {
            result += String.fromCharCode(96 + parseInt(s[i]));
            i++;
        }
    }
    return result;
}
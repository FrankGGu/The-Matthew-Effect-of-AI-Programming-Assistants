function freqAlphabets(s) {
    let result = '';
    for (let i = 0; i < s.length; i++) {
        if (s[i + 2] === '#') {
            result += String.fromCharCode(96 + Number(s.slice(i, i + 2)));
            i += 2;
        } else {
            result += String.fromCharCode(96 + Number(s[i]));
        }
    }
    return result;
}
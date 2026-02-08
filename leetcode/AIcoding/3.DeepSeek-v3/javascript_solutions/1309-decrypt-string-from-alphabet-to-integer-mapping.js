var freqAlphabets = function(s) {
    let result = [];
    let i = 0;
    const n = s.length;
    while (i < n) {
        if (i + 2 < n && s[i + 2] === '#') {
            const num = parseInt(s.substr(i, 2), 10);
            result.push(String.fromCharCode(num + 96));
            i += 3;
        } else {
            const num = parseInt(s[i], 10);
            result.push(String.fromCharCode(num + 96));
            i += 1;
        }
    }
    return result.join('');
};
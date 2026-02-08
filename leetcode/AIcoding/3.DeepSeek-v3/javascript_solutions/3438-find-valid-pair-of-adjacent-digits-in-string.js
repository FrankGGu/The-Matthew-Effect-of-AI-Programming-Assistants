var findValidPair = function(s) {
    for (let i = 0; i < s.length - 1; i++) {
        const first = parseInt(s[i]);
        const second = parseInt(s[i + 1]);
        if ((first % 2 === 0 && second % 2 === 0) || (first % 2 !== 0 && second % 2 !== 0)) {
            return [i, i + 1];
        }
    }
    return [-1, -1];
};
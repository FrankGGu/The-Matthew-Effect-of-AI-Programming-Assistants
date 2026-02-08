var encode = function(strs) {
    return strs.map(s => `${s.length}#${s}`).join('');
};

var decode = function(s) {
    const res = [];
    let i = 0;
    while (i < s.length) {
        let j = i;
        while (s[j] !== '#') j++;
        const length = parseInt(s.slice(i, j));
        res.push(s.slice(j + 1, j + 1 + length));
        i = j + 1 + length;
    }
    return res;
};
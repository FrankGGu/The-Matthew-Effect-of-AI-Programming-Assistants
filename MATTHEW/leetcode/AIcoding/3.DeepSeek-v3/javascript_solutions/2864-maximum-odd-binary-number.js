var maximumOddBinaryNumber = function(s) {
    let count = 0;
    for (let c of s) {
        if (c === '1') {
            count++;
        }
    }
    let res = [];
    for (let i = 0; i < s.length - 1; i++) {
        if (i < count - 1) {
            res.push('1');
        } else {
            res.push('0');
        }
    }
    res.push('1');
    return res.join('');
};
var makeLargestSpecial = function(s) {
    let count = 0, i = 0;
    const res = [];
    for (let j = 0; j < s.length; ++j) {
        if (s[j] === '1') {
            count++;
        } else {
            count--;
        }
        if (count === 0) {
            res.push('1' + makeLargestSpecial(s.substring(i + 1, j)) + '0');
            i = j + 1;
        }
    }
    res.sort((a, b) => b.localeCompare(a));
    return res.join('');
};
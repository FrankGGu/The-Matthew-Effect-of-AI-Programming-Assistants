var makeLargestSpecial = function(s) {
    if (!s) return "";
    let count = 0, start = 0;
    const subs = [];
    for (let i = 0; i < s.length; i++) {
        if (s[i] === '1') count++;
        else count--;
        if (count === 0) {
            subs.push('1' + makeLargestSpecial(s.substring(start + 1, i)) + '0');
            start = i + 1;
        }
    }
    subs.sort((a, b) => b.localeCompare(a));
    return subs.join('');
};
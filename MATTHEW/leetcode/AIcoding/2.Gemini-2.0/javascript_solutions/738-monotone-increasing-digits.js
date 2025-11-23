var monotoneIncreasingDigits = function(n) {
    let s = String(n).split('');
    let len = s.length;
    let flag = len;
    for (let i = len - 1; i > 0; i--) {
        if (s[i - 1] > s[i]) {
            s[i - 1]--;
            flag = i;
        }
    }
    for (let i = flag; i < len; i++) {
        s[i] = '9';
    }
    return parseInt(s.join(''));
};
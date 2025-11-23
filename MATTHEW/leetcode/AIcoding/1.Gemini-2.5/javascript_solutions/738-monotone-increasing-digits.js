var monotoneIncreasingDigits = function(n) {
    let s = String(n);
    let digits = s.split('').map(Number);
    let len = digits.length;
    let mark = len;

    for (let i = len - 1; i > 0; i--) {
        if (digits[i] < digits[i - 1]) {
            digits[i - 1]--;
            mark = i;
        }
    }

    for (let i = mark; i < len; i++) {
        digits[i] = 9;
    }

    return parseInt(digits.join(''));
};
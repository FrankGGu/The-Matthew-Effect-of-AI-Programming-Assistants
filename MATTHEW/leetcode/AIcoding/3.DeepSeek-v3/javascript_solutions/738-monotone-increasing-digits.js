var monotoneIncreasingDigits = function(n) {
    const digits = String(n).split('').map(Number);
    let marker = digits.length;
    for (let i = digits.length - 1; i > 0; i--) {
        if (digits[i] < digits[i - 1]) {
            marker = i;
            digits[i - 1]--;
        }
    }
    for (let i = marker; i < digits.length; i++) {
        digits[i] = 9;
    }
    return parseInt(digits.join(''), 10);
};
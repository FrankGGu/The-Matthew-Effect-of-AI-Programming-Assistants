function monotoneIncreasingDigits(n) {
    let digits = n.toString().split('').map(Number);
    let i = 0;
    while (i < digits.length - 1 && digits[i] <= digits[i + 1]) {
        i++;
    }
    if (i === digits.length - 1) {
        return n;
    }
    while (i >= 0 && digits[i] > digits[i + 1]) {
        digits[i]--;
        i--;
    }
    for (i++; i < digits.length; i++) {
        digits[i] = 9;
    }
    return parseInt(digits.join(''), 10);
}
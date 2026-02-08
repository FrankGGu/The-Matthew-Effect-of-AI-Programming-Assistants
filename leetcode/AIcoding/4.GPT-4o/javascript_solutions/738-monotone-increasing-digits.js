var monotoneIncreasingDigits = function(N) {
    let digits = String(N).split('');
    let n = digits.length;
    let mark = n;

    for (let i = n - 1; i > 0; i--) {
        if (digits[i] < digits[i - 1]) {
            mark = i; 
            digits[i - 1]--;
        }
    }

    for (let i = mark; i < n; i++) {
        digits[i] = '9';
    }

    return Number(digits.join(''));
};
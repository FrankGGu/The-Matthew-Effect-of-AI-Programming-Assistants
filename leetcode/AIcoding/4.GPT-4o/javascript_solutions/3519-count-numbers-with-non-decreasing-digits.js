var countNonDecreasingNumbers = function(N) {
    if (N < 10) return N + 1;
    let digits = N.toString().split('').map(Number);
    let count = 0;
    let len = digits.length;

    for (let i = 1; i < len; i++) {
        count += 10 ** (i - 1) * (9 - i + 1);
    }

    let prev = 0;
    for (let i = 0; i < len; i++) {
        for (let j = prev; j < digits[i]; j++) {
            count += 10 ** (len - i - 1);
        }
        if (i > 0 && digits[i] < digits[i - 1]) break;
        prev = digits[i];
    }

    return count + 1;
};
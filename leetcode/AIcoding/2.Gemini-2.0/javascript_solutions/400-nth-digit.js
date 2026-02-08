var findNthDigit = function(n) {
    let digits = 1;
    let count = 9;
    let start = 1;

    while (n > digits * count) {
        n -= digits * count;
        digits++;
        count *= 10;
        start *= 10;
    }

    const num = start + Math.floor((n - 1) / digits);
    const index = (n - 1) % digits;

    return parseInt(String(num)[index]);
};
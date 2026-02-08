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

    let numIndexInBlock = Math.floor((n - 1) / digits);
    let number = start + numIndexInBlock;

    let digitIndexInNumber = (n - 1) % digits;

    let s = String(number);
    return parseInt(s[digitIndexInNumber]);
};
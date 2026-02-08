var findNthDigit = function(n) {
    let digitLength = 1;
    let count = 9;
    let start = 1;

    while (n > digitLength * count) {
        n -= digitLength * count;
        digitLength++;
        count *= 10;
        start *= 10;
    }

    start += Math.floor((n - 1) / digitLength);
    const numStr = start.toString();
    return parseInt(numStr[(n - 1) % digitLength]);
};
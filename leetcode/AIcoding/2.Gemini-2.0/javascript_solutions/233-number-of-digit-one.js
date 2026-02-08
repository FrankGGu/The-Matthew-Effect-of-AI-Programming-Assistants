var countDigitOne = function(n) {
    let count = 0;
    let digit = 1;
    let high = Math.floor(n / 10);
    let current = n % 10;
    let low = 0;

    while (high !== 0 || current !== 0) {
        if (current === 0) {
            count += high * digit;
        } else if (current === 1) {
            count += high * digit + low + 1;
        } else {
            count += (high + 1) * digit;
        }

        low += current * digit;
        current = high % 10;
        high = Math.floor(high / 10);
        digit *= 10;
    }

    return count;
};
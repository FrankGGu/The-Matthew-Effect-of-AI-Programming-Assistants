var countDigitOne = function(n) {
    let count = 0;
    let i = 1;
    while (i <= n) {
        let divider = i * 10;
        count += Math.floor(n / divider) * i;
        let remainder = n % divider;
        if (remainder >= i * 2) {
            count += i;
        } else if (remainder >= i) {
            count += remainder - i + 1;
        }
        i *= 10;
    }
    return count;
};
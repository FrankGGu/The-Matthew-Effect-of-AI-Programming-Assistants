var countDigitOne = function(n) {
    let count = 0;
    let i = 1;

    while (i <= n) {
        let divider = i * 10;

        count += Math.floor(n / divider) * i;

        let remainder = n % divider;
        count += Math.min(Math.max(0, remainder - i + 1), i);

        if (i > n / 10) {
            break;
        }
        i *= 10;
    }

    return count;
};
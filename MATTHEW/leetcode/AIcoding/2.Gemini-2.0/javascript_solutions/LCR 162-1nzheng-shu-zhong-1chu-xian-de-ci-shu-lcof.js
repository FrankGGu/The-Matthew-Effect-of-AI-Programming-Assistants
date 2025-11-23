var countDigitOne = function(n) {
    let count = 0;
    let factor = 1;
    while (n / factor > 0) {
        let digit = Math.floor((n / factor)) % 10;
        let high = Math.floor(n / (factor * 10));
        let low = n % factor;

        if (digit === 0) {
            count += high * factor;
        } else if (digit === 1) {
            count += high * factor + low + 1;
        } else {
            count += (high + 1) * factor;
        }
        factor *= 10;
    }
    return count;
};
var hasAlternatingBits = function(n) {
    let prevBit = -1;
    while (n > 0) {
        let currentBit = n % 2;
        if (currentBit === prevBit) {
            return false;
        }
        prevBit = currentBit;
        n = Math.floor(n / 2);
    }
    return true;
};
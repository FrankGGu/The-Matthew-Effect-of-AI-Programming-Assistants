var hasAlternatingBits = function(n) {
    let prevBit = n & 1;
    n >>= 1;
    while (n > 0) {
        const currentBit = n & 1;
        if (currentBit === prevBit) {
            return false;
        }
        prevBit = currentBit;
        n >>= 1;
    }
    return true;
};
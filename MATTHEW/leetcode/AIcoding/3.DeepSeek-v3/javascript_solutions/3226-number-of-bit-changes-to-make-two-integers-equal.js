var minBitFlips = function(a, b) {
    let xor = a ^ b;
    let count = 0;
    while (xor !== 0) {
        count += xor & 1;
        xor = xor >>> 1;
    }
    return count;
};
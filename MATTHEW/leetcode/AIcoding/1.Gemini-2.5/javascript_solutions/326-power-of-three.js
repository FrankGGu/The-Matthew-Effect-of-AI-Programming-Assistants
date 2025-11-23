var isPowerOfThree = function(n) {
    // 1162261467 is 3^19, the largest power of 3 that fits within a signed 32-bit integer.
    // If n is a power of 3, and n is positive, then 3^19 must be divisible by n.
    return n > 0 && 1162261467 % n === 0;
};
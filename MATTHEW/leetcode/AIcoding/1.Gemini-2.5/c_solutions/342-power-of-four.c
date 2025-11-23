bool isPowerOfFour(int n) {
    if (n <= 0) {
        return false;
    }
    if ((n & (n - 1)) != 0) { // Check if n is a power of 2
        return false;
    }
    // Check if the set bit is at an even position (0-indexed)
    // For power of 4, the set bit will be at 0, 2, 4, 6...
    // This means it should not be at 1, 3, 5, 7...
    // Numbers like 2, 8, 32, 128... are powers of 2 but not powers of 4.
    // Their set bit is at an odd position.
    // We can check this by ANDing with a mask where bits at odd positions are set.
    // The mask 0xAAAAAAAA (binary 10101010...1010) has all odd bits set.
    // If n is a power of 4, its only set bit will be at an even position,
    // so n & 0xAAAAAAAA will be 0.
    return (n & 0xAAAAAAAA) == 0;
}
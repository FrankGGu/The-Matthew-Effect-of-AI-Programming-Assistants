int minimumOneBitOperations(int n) {
    if (n == 0) return 0;
    int highestBit = 1;
    while (highestBit <= n) {
        highestBit <<= 1;
    }
    highestBit >>= 1;
    return (highestBit - 1) ^ minimumOneBitOperations(n ^ highestBit);
}
int minBitFlips(int start, int goal) {
    int xor = start ^ goal;
    int count = 0;
    while (xor) {
        count += xor & 1;
        xor >>= 1;
    }
    return count;
}
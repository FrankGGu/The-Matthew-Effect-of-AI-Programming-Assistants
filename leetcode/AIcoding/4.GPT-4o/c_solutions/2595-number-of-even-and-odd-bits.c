int[] evenOddBit(int n) {
    int evenCount = 0, oddCount = 0;
    for (int i = 0; n > 0; i++) {
        if (n & 1) {
            if (i % 2 == 0) evenCount++;
            else oddCount++;
        }
        n >>= 1;
    }
    return (int[]) {evenCount, oddCount};
}
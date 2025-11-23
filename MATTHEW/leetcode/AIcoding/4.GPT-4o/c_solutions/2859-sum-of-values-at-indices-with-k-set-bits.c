int sumIndicesWithKSetBits(int* A, int ASize, int K) {
    int totalSum = 0;
    for (int i = 0; i < ASize; i++) {
        int count = __builtin_popcount(i);
        if (count == K) {
            totalSum += A[i];
        }
    }
    return totalSum;
}
int minOperations(int* A, int ASize, int K) {
    int totalSum = 0;
    for (int i = 0; i < ASize; i++) {
        totalSum += A[i];
    }
    if (totalSum % K == 0) return 0;

    int minOps = ASize + 1;
    int currentSum = 0;

    for (int i = 0; i < ASize; i++) {
        currentSum += A[i];
        if (currentSum % K == totalSum % K) {
            minOps = (i + 1 < minOps) ? i + 1 : minOps;
        }
    }

    currentSum = 0;
    for (int i = ASize - 1; i >= 0; i--) {
        currentSum += A[i];
        if (currentSum % K == totalSum % K) {
            minOps = (ASize - i < minOps) ? ASize - i : minOps;
        }
    }

    return minOps == ASize + 1 ? -1 : minOps;
}
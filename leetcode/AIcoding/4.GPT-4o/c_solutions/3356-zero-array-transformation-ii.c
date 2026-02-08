bool canTransform(int* A, int ASize, int* B, int BSize) {
    int sumA = 0, sumB = 0;
    for (int i = 0; i < ASize; i++) {
        sumA += A[i];
        sumB += B[i];
    }
    if (sumA != sumB) return false;

    int countA[100001] = {0}, countB[100001] = {0};
    for (int i = 0; i < ASize; i++) {
        countA[A[i] + 50000]++;
        countB[B[i] + 50000]++;
    }

    for (int i = 0; i < 100001; i++) {
        if (countA[i] != countB[i]) return false;
    }
    return true;
}
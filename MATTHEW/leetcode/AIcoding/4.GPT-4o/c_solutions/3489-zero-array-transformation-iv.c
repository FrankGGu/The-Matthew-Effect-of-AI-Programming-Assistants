bool canTransform(int* A, int ASize, int* B, int BSize) {
    int countA[1001] = {0}, countB[1001] = {0};
    for (int i = 0; i < ASize; i++) {
        countA[A[i]]++;
        countB[B[i]]++;
    }
    for (int i = 0; i < 1001; i++) {
        if (countA[i] != countB[i]) return false;
    }
    return true;
}
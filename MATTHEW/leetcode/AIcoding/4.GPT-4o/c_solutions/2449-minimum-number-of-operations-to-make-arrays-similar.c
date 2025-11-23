int minOperations(int* A, int ASize, int* B, int BSize) {
    int countA[101] = {0}, countB[101] = {0};
    for (int i = 0; i < ASize; i++) {
        countA[A[i]]++;
        countB[B[i]]++;
    }

    int totalA = 0, totalB = 0;
    for (int i = 0; i < 101; i++) {
        totalA += countA[i] * i;
        totalB += countB[i] * i;
    }

    if (totalA != totalB) return -1;

    int operations = 0;
    for (int i = 0; i < 101; i++) {
        if (countA[i] > countB[i]) {
            operations += (countA[i] - countB[i]) / 2;
        }
    }

    return operations;
}
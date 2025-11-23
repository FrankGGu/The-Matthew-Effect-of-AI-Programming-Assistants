int* fairCandySwap(int* A, int ASize, int* B, int BSize, int* returnSize) {
    int sumA = 0, sumB = 0;
    for (int i = 0; i < ASize; i++) sumA += A[i];
    for (int i = 0; i < BSize; i++) sumB += B[i];

    int target = (sumA - sumB) / 2;
    int* setB = (int*)malloc(100001 * sizeof(int));
    for (int i = 0; i < BSize; i++) setB[B[i]] = 1;

    int* result = (int*)malloc(2 * sizeof(int));
    for (int i = 0; i < ASize; i++) {
        if (setB[A[i] - target]) {
            result[0] = A[i];
            result[1] = A[i] - target;
            break;
        }
    }

    *returnSize = 2;
    free(setB);
    return result;
}
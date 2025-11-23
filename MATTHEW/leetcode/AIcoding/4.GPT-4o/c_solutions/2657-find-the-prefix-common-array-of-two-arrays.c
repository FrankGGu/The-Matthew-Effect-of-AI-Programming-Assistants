int* findThePrefixCommonArray(int* A, int ASize, int* B, int BSize, int* returnSize) {
    int* result = (int*)malloc(ASize * sizeof(int));
    int countA[1001] = {0}, countB[1001] = {0};
    *returnSize = ASize;

    for (int i = 0; i < ASize; i++) {
        countA[A[i]]++;
        countB[B[i]]++;
        result[i] = (i == 0) ? (countA[A[i]] > 0 && countB[A[i]] > 0) : result[i - 1];

        if (countA[A[i]] > 0 && countB[A[i]] > 0) {
            result[i]++;
        }
    }

    return result;
}
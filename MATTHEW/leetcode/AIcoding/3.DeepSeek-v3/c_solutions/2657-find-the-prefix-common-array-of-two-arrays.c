/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* findThePrefixCommonArray(int* A, int* B, int ASize, int* returnSize) {
    int* C = (int*)malloc(ASize * sizeof(int));
    *returnSize = ASize;

    int* count = (int*)calloc(ASize + 1, sizeof(int));
    int common = 0;

    for (int i = 0; i < ASize; i++) {
        count[A[i]]++;
        if (count[A[i]] == 2) common++;

        count[B[i]]++;
        if (count[B[i]] == 2) common++;

        C[i] = common;
    }

    free(count);
    return C;
}
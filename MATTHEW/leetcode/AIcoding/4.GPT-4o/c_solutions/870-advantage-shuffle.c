#include <stdlib.h>

int cmp(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

int* advantageCount(int* A, int ASize, int* B, int BSize, int* returnSize) {
    int* result = (int*)malloc(ASize * sizeof(int));
    int* sortedA = (int*)malloc(ASize * sizeof(int));
    int* sortedB = (int*)malloc(BSize * sizeof(int));
    int* indexB = (int*)malloc(BSize * sizeof(int));

    for (int i = 0; i < ASize; i++) {
        sortedA[i] = A[i];
    }

    for (int i = 0; i < BSize; i++) {
        sortedB[i] = B[i];
        indexB[i] = i;
    }

    qsort(sortedA, ASize, sizeof(int), cmp);
    qsort(indexB, BSize, sizeof(int), cmp);

    int j = 0;
    for (int i = 0; i < ASize; i++) {
        if (sortedA[i] > sortedB[j]) {
            result[indexB[j]] = sortedA[i];
            j++;
        } else {
            result[indexB[BSize - 1 - (i - j)]] = sortedA[i];
        }
    }

    free(sortedA);
    free(sortedB);
    free(indexB);

    *returnSize = ASize;
    return result;
}
#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* arrayRankTransform(int* arr, int arrSize, int* returnSize) {
    int* sorted = (int*)malloc(arrSize * sizeof(int));
    for (int i = 0; i < arrSize; i++) {
        sorted[i] = arr[i];
    }
    qsort(sorted, arrSize, sizeof(int), compare);

    int* rankMap = (int*)malloc(100001 * sizeof(int));
    int rank = 1;
    for (int i = 0; i < arrSize; i++) {
        if (i == 0 || sorted[i] != sorted[i - 1]) {
            rankMap[sorted[i]] = rank++;
        }
    }

    int* result = (int*)malloc(arrSize * sizeof(int));
    for (int i = 0; i < arrSize; i++) {
        result[i] = rankMap[arr[i]];
    }

    free(sorted);
    free(rankMap);
    *returnSize = arrSize;
    return result;
}
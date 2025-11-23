#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* arrayRankTransform(int* arr, int arrSize, int* returnSize) {
    int* sortedArr = (int*)malloc(arrSize * sizeof(int));
    for (int i = 0; i < arrSize; i++) {
        sortedArr[i] = arr[i];
    }

    qsort(sortedArr, arrSize, sizeof(int), compare);

    int* rankMap = (int*)malloc(200001 * sizeof(int));
    for (int i = 0; i < 200001; i++) {
        rankMap[i] = 0;
    }

    int rank = 1;
    for (int i = 0; i < arrSize; i++) {
        if (rankMap[sortedArr[i] + 100000] == 0) {
            rankMap[sortedArr[i] + 100000] = rank++;
        }
    }

    int* result = (int*)malloc(arrSize * sizeof(int));
    for (int i = 0; i < arrSize; i++) {
        result[i] = rankMap[arr[i] + 100000];
    }

    free(sortedArr);
    free(rankMap);

    *returnSize = arrSize;
    return result;
}
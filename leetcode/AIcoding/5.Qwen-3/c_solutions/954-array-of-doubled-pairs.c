#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

bool canBeEqual(int* target, int targetSize) {
    qsort(target, targetSize, sizeof(int), compare);
    int* arr = (int *)malloc(targetSize * sizeof(int));
    for (int i = 0; i < targetSize; i++) {
        arr[i] = target[i];
    }
    for (int i = 0; i < targetSize; i++) {
        if (arr[i] != target[i]) {
            free(arr);
            return false;
        }
    }
    free(arr);
    return true;
}

bool canBeArranged(int* arr, int arrSize) {
    int* count = (int *)calloc(20001, sizeof(int));
    for (int i = 0; i < arrSize; i++) {
        count[arr[i] + 10000]++;
    }
    qsort(arr, arrSize, sizeof(int), compare);
    for (int i = 0; i < arrSize; i++) {
        if (count[arr[i] + 10000] == 0) continue;
        if (arr[i] * 2 > 20000 || count[arr[i] * 2 + 10000] == 0) {
            free(count);
            return false;
        }
        count[arr[i] + 10000]--;
        count[arr[i] * 2 + 10000]--;
    }
    free(count);
    return true;
}

bool canReorderDoubledPairs(int* arr, int arrSize) {
    if (arrSize % 2 != 0) return false;
    return canBeArranged(arr, arrSize);
}
#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    int x = *(int*)a;
    int y = *(int*)b;
    int countX = 0, countY = 0;
    while (x > 0) {
        countX += x & 1;
        x >>= 1;
    }
    while (y > 0) {
        countY += y & 1;
        y >>= 1;
    }
    return countX - countY;
}

int* sortJumbled(int* arr, int arrSize, int* returnSize) {
    int* result = (int*)malloc(arrSize * sizeof(int));
    for (int i = 0; i < arrSize; i++) {
        result[i] = arr[i];
    }
    qsort(result, arrSize, sizeof(int), compare);
    *returnSize = arrSize;
    return result;
}
#include <stdio.h>
#include <stdlib.h>

int getPowerValue(int x) {
    int count = 0;
    while (x != 1) {
        if (x % 2 == 0) {
            x /= 2;
        } else {
            x = 3 * x + 1;
        }
        count++;
    }
    return count;
}

int compare(const void *a, const void *b) {
    int x = *(int*)a;
    int y = *(int*)b;
    int powerX = getPowerValue(x);
    int powerY = getPowerValue(y);
    return powerX - powerY;
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
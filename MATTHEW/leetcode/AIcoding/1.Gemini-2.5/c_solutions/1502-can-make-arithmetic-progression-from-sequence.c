#include <stdlib.h>
#include <stdbool.h>

int compareInts(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

bool canMakeArithmeticProgression(int* arr, int arrSize) {
    if (arrSize <= 2) {
        return true;
    }

    qsort(arr, arrSize, sizeof(int), compareInts);

    int commonDiff = arr[1] - arr[0];

    for (int i = 2; i < arrSize; i++) {
        if (arr[i] - arr[i-1] != commonDiff) {
            return false;
        }
    }

    return true;
}
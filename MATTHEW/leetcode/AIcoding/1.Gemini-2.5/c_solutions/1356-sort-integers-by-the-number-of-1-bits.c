#include <stdlib.h> // Required for qsort

static int countSetBits(int n) {
    return __builtin_popcount(n);
}

static int compare(const void *a, const void *b) {
    int valA = *(const int *)a;
    int valB = *(const int *)b;

    int popcountA = countSetBits(valA);
    int popcountB = countSetBits(valB);

    if (popcountA != popcountB) {
        return popcountA - popcountB;
    } else {
        return valA - valB;
    }
}

int* sortArrayByBits(int* arr, int arrSize, int* returnSize) {
    qsort(arr, arrSize, sizeof(int), compare);

    *returnSize = arrSize;
    return arr;
}
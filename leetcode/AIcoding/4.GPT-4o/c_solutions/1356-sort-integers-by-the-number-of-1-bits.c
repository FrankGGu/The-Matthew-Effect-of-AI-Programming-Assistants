#include <stdlib.h>

int countBits(int n) {
    int count = 0;
    while (n) {
        count += n & 1;
        n >>= 1;
    }
    return count;
}

int compare(const void *a, const void *b) {
    int bitsA = countBits(*(int *)a);
    int bitsB = countBits(*(int *)b);
    if (bitsA == bitsB) {
        return *(int *)a - *(int *)b;
    }
    return bitsA - bitsB;
}

int* sortByBits(int* arr, int arrSize, int* returnSize) {
    *returnSize = arrSize;
    qsort(arr, arrSize, sizeof(int), compare);
    return arr;
}
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSetBits(int n) {
    int count = 0;
    while (n > 0) {
        n &= (n - 1);
        count++;
    }
    return count;
}

int compare(const void *a, const void *b) {
    int num1 = *(int *)a;
    int num2 = *(int *)b;
    int bits1 = countSetBits(num1);
    int bits2 = countSetBits(num2);

    if (bits1 == bits2) {
        return num1 - num2;
    } else {
        return bits1 - bits2;
    }
}

int* sortByBits(int* arr, int arrSize, int* returnSize) {
    qsort(arr, arrSize, sizeof(int), compare);
    *returnSize = arrSize;
    return arr;
}
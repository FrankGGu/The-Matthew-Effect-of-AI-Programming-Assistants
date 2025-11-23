#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* maximumEvenSplit(int finalSum, int* returnSize) {
    if (finalSum % 2 != 0) {
        *returnSize = 0;
        return NULL;
    }

    int* result = (int*)malloc(sizeof(int) * (finalSum / 2 + 1));
    int count = 0;
    int current = 2;
    while (finalSum >= current) {
        result[count++] = current;
        finalSum -= current;
        current += 2;
    }
    result[count - 1] += finalSum;

    *returnSize = count;
    return result;
}
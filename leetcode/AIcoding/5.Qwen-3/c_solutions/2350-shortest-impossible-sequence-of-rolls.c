#include <stdio.h>
#include <stdlib.h>

int* nums;
int numsSize;

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int* shortestImpossibleSequence(int* rolls, int rollsSize, int* returnSize) {
    qsort(rolls, rollsSize, sizeof(int), compare);
    int* result = (int*)malloc(2 * sizeof(int));
    int sum = 0;
    for (int i = 0; i < rollsSize; i++) {
        if (rolls[i] > sum + 1) {
            break;
        }
        sum += rolls[i];
    }
    result[0] = sum + 1;
    result[1] = sum + 1;
    *returnSize = 2;
    return result;
}
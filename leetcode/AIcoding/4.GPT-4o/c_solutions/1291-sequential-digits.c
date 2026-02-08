#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* sequentialDigits(int low, int high, int* returnSize) {
    int* result = (int*)malloc(100 * sizeof(int));
    *returnSize = 0;

    for (int start = 1; start <= 9; start++) {
        int num = start;
        for (int next = start + 1; next <= 9; next++) {
            num = num * 10 + next;
            if (num > high) break;
            if (num >= low) {
                result[(*returnSize)++] = num;
            }
        }
    }

    qsort(result, *returnSize, sizeof(int), cmp);

    return result;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}
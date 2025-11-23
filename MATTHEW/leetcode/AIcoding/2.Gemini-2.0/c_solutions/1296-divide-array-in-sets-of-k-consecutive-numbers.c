#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

bool isPossibleDivide(int* nums, int numsSize, int k) {
    if (numsSize % k != 0) {
        return false;
    }

    qsort(nums, numsSize, sizeof(int), cmp);

    int *counts = (int*)malloc(sizeof(int) * numsSize);
    for (int i = 0; i < numsSize; i++) {
        counts[i] = 1;
    }

    for (int i = 0; i < numsSize; i++) {
        if (counts[i] == 0) {
            continue;
        }

        int current = nums[i];
        counts[i] = 0;
        int count = 1;

        for (int j = i + 1; j < numsSize; j++) {
            if (nums[j] == current + 1 && counts[j] == 1) {
                counts[j] = 0;
                current = nums[j];
                count++;
            }
            if (count == k) break;
        }

        if (count != k) {
            free(counts);
            return false;
        }
    }

    free(counts);
    return true;
}
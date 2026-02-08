#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* goodIndices(int* nums, int numsSize, int k, int* returnSize) {
    if (numsSize < 2 * k + 1) {
        *returnSize = 0;
        return NULL;
    }

    int* good_indices = (int*)malloc(numsSize * sizeof(int));
    int count = 0;

    for (int i = k; i < numsSize - k; i++) {
        int decreasing = 1;
        for (int j = i - k; j < i - 1; j++) {
            if (nums[j] > nums[j + 1]) {
                decreasing = 0;
                break;
            }
        }

        if (!decreasing) continue;

        int increasing = 1;
        for (int j = i + k; j > i; j--) {
            if (nums[j] > nums[j - 1]) {
                increasing = 0;
                break;
            }
        }

        if (!increasing) continue;

        good_indices[count++] = i;
    }

    *returnSize = count;
    return good_indices;
}
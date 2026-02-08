#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** subsetsWithDup(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    int** result;
    int* temp;
    int i, j, k;
    int count = 1;
    int* freq;
    int uniqueCount = 0;
    int prev = -1;

    qsort(nums, numsSize, sizeof(int), (int (*)(const void*, const void*))strcmp);

    for (i = 0; i < numsSize; i++) {
        if (i == 0 || nums[i] != nums[i - 1]) {
            uniqueCount++;
        }
    }

    freq = (int*)malloc(uniqueCount * sizeof(int));
    temp = (int*)malloc(uniqueCount * sizeof(int));

    for (i = 0, j = 0; i < numsSize; i++) {
        if (i == 0 || nums[i] != nums[i - 1]) {
            freq[j++] = 1;
        } else {
            freq[j - 1]++;
        }
    }

    for (i = 0; i < uniqueCount; i++) {
        count *= (freq[i] + 1);
    }

    result = (int**)malloc(count * sizeof(int*));
    *returnColumnSizes = (int*)malloc(count * sizeof(int));
    *returnSize = count;

    for (i = 0; i < count; i++) {
        result[i] = (int*)malloc(uniqueCount * sizeof(int));
        (*returnColumnSizes)[i] = 0;
    }

    for (i = 0; i < uniqueCount; i++) {
        for (j = 0; j < count; j++) {
            if (j % (freq[i] + 1) == 0) {
                temp[i] = 0;
            } else {
                temp[i]++;
            }
        }
    }

    for (i = 0; i < count; i++) {
        int index = 0;
        for (j = 0; j < uniqueCount; j++) {
            for (k = 0; k < temp[j]; k++) {
                result[i][index++] = nums[j];
            }
        }
        (*returnColumnSizes)[i] = index;
    }

    free(temp);
    free(freq);

    return result;
}
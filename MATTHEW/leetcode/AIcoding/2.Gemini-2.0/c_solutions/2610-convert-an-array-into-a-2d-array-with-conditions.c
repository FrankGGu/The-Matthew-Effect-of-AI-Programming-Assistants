#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** findMatrix(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    int counts[201] = {0};
    int maxCount = 0;
    for (int i = 0; i < numsSize; i++) {
        counts[nums[i]]++;
        if (counts[nums[i]] > maxCount) {
            maxCount = counts[nums[i]];
        }
    }

    int** result = (int**)malloc(maxCount * sizeof(int*));
    *returnColumnSizes = (int*)malloc(maxCount * sizeof(int));
    *returnSize = maxCount;

    for (int i = 0; i < maxCount; i++) {
        (*returnColumnSizes)[i] = 0;
        result[i] = (int*)malloc(numsSize * sizeof(int));
    }

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        int row = 0;
        while (row < maxCount) {
            int found = 0;
            for (int j = 0; j < (*returnColumnSizes)[row]; j++) {
                if (result[row][j] == num) {
                    found = 1;
                    break;
                }
            }
            if (!found) {
                result[row][(*returnColumnSizes)[row]] = num;
                (*returnColumnSizes)[row]++;
                break;
            }
            row++;
        }
    }

    return result;
}
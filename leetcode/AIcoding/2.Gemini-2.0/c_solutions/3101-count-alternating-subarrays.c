#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* alternatingSubarray(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            int len = j - i + 1;
            if (len % 2 == 0) {
                int diff = nums[i + 1] - nums[i];
                if (diff != 1) continue;
                int flag = 1;
                for (int k = i + 1; k < j; k++) {
                    if (nums[k + 1] - nums[k] != -diff) {
                        flag = 0;
                        break;
                    }
                    diff *= -1;
                }
                if (flag) {
                    result[(*returnSize)++] = len;
                }
            } else {
                int diff = nums[i + 1] - nums[i];
                if (diff != 1) continue;
                int flag = 1;
                for (int k = i + 1; k < j; k++) {
                    if (nums[k + 1] - nums[k] != -diff) {
                        flag = 0;
                        break;
                    }
                    diff *= -1;
                }
                if (flag) {
                    result[(*returnSize)++] = len;
                }
            }
        }
    }

    if (*returnSize == 0) {
        *returnSize = 1;
        result = (int*)malloc(sizeof(int));
        result[0] = -1;
    } else {
        int* temp = (int*)malloc((*returnSize) * sizeof(int));
        for(int i = 0; i < *returnSize; i++) {
            temp[i] = result[i];
        }
        free(result);
        result = temp;
    }
    return result;
}
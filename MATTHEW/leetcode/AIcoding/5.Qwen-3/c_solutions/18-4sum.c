#include <stdio.h>
#include <stdlib.h>

int** fourSum(int* nums, int numsSize, int target, int* returnSize, int** returnColumnSizes) {
    *returnSize = 0;
    if (numsSize < 4) return NULL;

    int** result = (int**)malloc(sizeof(int*));
    *returnColumnSizes = (int*)malloc(sizeof(int));

    qsort(nums, numsSize, sizeof(int), (int(*)(const void*, const void*))strcmp);

    for (int i = 0; i < numsSize - 3; i++) {
        if (i > 0 && nums[i] == nums[i - 1]) continue;
        for (int j = i + 1; j < numsSize - 2; j++) {
            if (j > i + 1 && nums[j] == nums[j - 1]) continue;
            int left = j + 1;
            int right = numsSize - 1;
            while (left < right) {
                long sum = (long)nums[i] + nums[j] + nums[left] + nums[right];
                if (sum == target) {
                    (*returnSize)++;
                    result = (int**)realloc(result, *returnSize * sizeof(int*));
                    returnColumnSizes = (int*)realloc(*returnColumnSizes, *returnSize * sizeof(int));
                    result[*returnSize - 1] = (int*)malloc(4 * sizeof(int));
                    result[*returnSize - 1][0] = nums[i];
                    result[*returnSize - 1][1] = nums[j];
                    result[*returnSize - 1][2] = nums[left];
                    result[*returnSize - 1][3] = nums[right];
                    returnColumnSizes[*returnSize - 1] = 4;

                    while (left < right && nums[left] == nums[left + 1]) left++;
                    while (left < right && nums[right] == nums[right - 1]) right--;
                    left++;
                    right--;
                } else if (sum < target) {
                    left++;
                } else {
                    right--;
                }
            }
        }
    }

    return result;
}
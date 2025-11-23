#include <stdio.h>
#include <stdlib.h>

int** threeSum(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    *returnSize = 0;
    if (numsSize < 3) return NULL;

    int** result = (int**)malloc(sizeof(int*));
    *returnColumnSizes = (int*)malloc(sizeof(int));

    qsort(nums, numsSize, sizeof(int), (int (*)(const void*, const void*))strcmp);

    for (int i = 0; i < numsSize - 2; i++) {
        if (i > 0 && nums[i] == nums[i - 1]) continue;

        int left = i + 1;
        int right = numsSize - 1;
        int target = -nums[i];

        while (left < right) {
            int sum = nums[left] + nums[right];
            if (sum == target) {
                (*returnSize)++;
                result = (int**)realloc(result, (*returnSize) * sizeof(int*));
                returnColumnSizes = (int*)realloc(*returnColumnSizes, (*returnSize) * sizeof(int));
                result[*returnSize - 1] = (int*)malloc(3 * sizeof(int));
                result[*returnSize - 1][0] = nums[i];
                result[*returnSize - 1][1] = nums[left];
                result[*returnSize - 1][2] = nums[right];
                returnColumnSizes[*returnSize - 1] = 3;

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

    return result;
}
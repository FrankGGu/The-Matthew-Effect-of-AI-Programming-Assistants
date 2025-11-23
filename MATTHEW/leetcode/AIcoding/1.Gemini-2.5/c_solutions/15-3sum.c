#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int** threeSum(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    *returnSize = 0;
    if (numsSize < 3) {
        *returnColumnSizes = NULL;
        return NULL;
    }

    qsort(nums, numsSize, sizeof(int), compare);

    int** result = NULL;
    *returnColumnSizes = NULL;

    for (int i = 0; i < numsSize - 2; i++) {
        if (i > 0 && nums[i] == nums[i-1]) {
            continue;
        }

        if (nums[i] > 0) {
            break;
        }

        int left = i + 1;
        int right = numsSize - 1;

        while (left < right) {
            int sum = nums[i] + nums[left] + nums[right];

            if (sum == 0) {
                *returnSize += 1;
                result = (int**)realloc(result, (*returnSize) * sizeof(int*));
                result[*returnSize - 1] = (int*)malloc(3 * sizeof(int));
                result[*returnSize - 1][0] = nums[i];
                result[*returnSize - 1][1] = nums[left];
                result[*returnSize - 1][2] = nums[right];

                *returnColumnSizes = (int*)realloc(*returnColumnSizes, (*returnSize) * sizeof(int));
                (*returnColumnSizes)[*returnSize - 1] = 3;

                while (left < right && nums[left] == nums[left + 1]) {
                    left++;
                }
                while (left < right && nums[right] == nums[right - 1]) {
                    right--;
                }

                left++;
                right--;
            } else if (sum < 0) {
                left++;
            } else {
                right--;
            }
        }
    }

    return result;
}
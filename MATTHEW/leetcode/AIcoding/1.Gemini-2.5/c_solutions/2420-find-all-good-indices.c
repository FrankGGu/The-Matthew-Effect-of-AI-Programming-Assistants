#include <stdlib.h>

int* goodIndices(int* nums, int numsSize, int k, int* returnSize) {
    if (numsSize < 2 * k + 1) {
        *returnSize = 0;
        return NULL;
    }

    int* left_non_inc = (int*)malloc(numsSize * sizeof(int));
    int* right_non_dec = (int*)malloc(numsSize * sizeof(int));

    left_non_inc[0] = 1;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] <= nums[i-1]) {
            left_non_inc[i] = left_non_inc[i-1] + 1;
        } else {
            left_non_inc[i] = 1;
        }
    }

    right_non_dec[numsSize - 1] = 1;
    for (int i = numsSize - 2; i >= 0; i--) {
        if (nums[i] <= nums[i+1]) {
            right_non_dec[i] = right_non_dec[i+1] + 1;
        } else {
            right_non_dec[i] = 1;
        }
    }

    int* temp_result = (int*)malloc(numsSize * sizeof(int));
    int count = 0;

    for (int i = k; i < numsSize - k; i++) {
        if (left_non_inc[i-1] >= k && right_non_dec[i+1] >= k) {
            temp_result[count++] = i;
        }
    }

    *returnSize = count;

    int* final_result = (int*)malloc(count * sizeof(int));
    for (int i = 0; i < count; i++) {
        final_result[i] = temp_result[i];
    }

    free(left_non_inc);
    free(right_non_dec);
    free(temp_result);

    return final_result;
}
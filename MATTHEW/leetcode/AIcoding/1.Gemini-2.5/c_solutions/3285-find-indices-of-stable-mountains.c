#include <stdlib.h>

int* stableMountains(int* nums, int numsSize, int* returnSize) {
    if (numsSize < 3) {
        *returnSize = 0;
        return NULL;
    }

    int* inc_len = (int*)malloc(numsSize * sizeof(int));
    int* dec_len = (int*)malloc(numsSize * sizeof(int));

    inc_len[0] = 1;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > nums[i-1]) {
            inc_len[i] = inc_len[i-1] + 1;
        } else {
            inc_len[i] = 1;
        }
    }

    dec_len[numsSize - 1] = 1;
    for (int i = numsSize - 2; i >= 0; i--) {
        if (nums[i] > nums[i+1]) {
            dec_len[i] = dec_len[i+1] + 1;
        } else {
            dec_len[i] = 1;
        }
    }

    int* result = (int*)malloc(numsSize * sizeof(int));
    int result_count = 0;

    for (int i = 1; i < numsSize - 1; i++) {
        if (inc_len[i] > 1 && dec_len[i] > 1) {
            int l = i - inc_len[i] + 1;
            int r = i + dec_len[i] - 1;

            if (nums[l] == nums[r]) {
                result[result_count++] = i;
            }
        }
    }

    if (result_count == 0) {
        free(result);
        result = NULL;
    } else {
        result = (int*)realloc(result, result_count * sizeof(int));
    }

    *returnSize = result_count;

    free(inc_len);
    free(dec_len);

    return result;
}
#include <stdlib.h>

int* maxScoreIndices(int* nums, int numsSize, int* returnSize) {
    int total_ones = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) {
            total_ones++;
        }
    }

    int zeros_left = 0;
    int ones_right = total_ones;
    int max_score = -1;

    int* result_indices = (int*)malloc(sizeof(int) * (numsSize + 1));
    int result_count = 0;

    for (int i = 0; i <= numsSize; i++) {
        int current_score = zeros_left + ones_right;

        if (current_score > max_score) {
            max_score = current_score;
            result_count = 0;
            result_indices[result_count++] = i;
        } else if (current_score == max_score) {
            result_indices[result_count++] = i;
        }

        if (i < numsSize) {
            if (nums[i] == 0) {
                zeros_left++;
            } else {
                ones_right--;
            }
        }
    }

    *returnSize = result_count;
    return result_indices;
}
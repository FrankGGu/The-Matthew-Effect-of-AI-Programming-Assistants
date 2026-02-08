#include <stdlib.h> // For malloc and abs

int* findIndices(int* nums, int numsSize, int indexDifference, int valueDifference, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * 2);
    *returnSize = 2;

    int min_val_idx = 0;
    int max_val_idx = 0;

    for (int j = indexDifference; j < numsSize; j++) {
        int current_i_candidate_for_minmax = j - indexDifference;
        if (nums[current_i_candidate_for_minmax] < nums[min_val_idx]) {
            min_val_idx = current_i_candidate_for_minmax;
        }
        if (nums[current_i_candidate_for_minmax] > nums[max_val_idx]) {
            max_val_idx = current_i_candidate_for_minmax;
        }

        if (abs(nums[min_val_idx] - nums[j]) >= valueDifference) {
            result[0] = min_val_idx;
            result[1] = j;
            return result;
        }
        if (abs(nums[max_val_idx] - nums[j]) >= valueDifference) {
            result[0] = max_val_idx;
            result[1] = j;
            return result;
        }
    }

    result[0] = -1;
    result[1] = -1;
    return result;
}
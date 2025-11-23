#include <stdlib.h>

int* createTargetArray(int* nums, int numsSize, int* index, int indexSize, int* returnSize) {
    int* target = (int*)malloc(numsSize * sizeof(int));
    int current_target_size = 0;

    for (int i = 0; i < numsSize; i++) {
        int num_to_insert = nums[i];
        int insert_idx = index[i];

        if (insert_idx < current_target_size) {
            for (int j = current_target_size - 1; j >= insert_idx; j--) {
                target[j + 1] = target[j];
            }
        }

        target[insert_idx] = num_to_insert;
        current_target_size++;
    }

    *returnSize = numsSize;
    return target;
}
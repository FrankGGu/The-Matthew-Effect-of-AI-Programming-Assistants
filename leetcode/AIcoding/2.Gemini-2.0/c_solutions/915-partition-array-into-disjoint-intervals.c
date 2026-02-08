#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int partitionDisjoint(int* nums, int numsSize) {
    int max_left = nums[0];
    int current_max = nums[0];
    int partition_index = 0;

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < max_left) {
            partition_index = i;
            max_left = current_max;
        } else {
            if (nums[i] > current_max) {
                current_max = nums[i];
            }
        }
    }

    return partition_index + 1;
}
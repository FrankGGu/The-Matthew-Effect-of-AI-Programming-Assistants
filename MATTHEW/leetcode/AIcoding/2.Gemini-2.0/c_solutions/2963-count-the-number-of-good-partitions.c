#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int countPartitions(int* nums, int numsSize) {
    int max_val = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max_val) {
            max_val = nums[i];
        }
    }

    int* last_occurrence = (int*)malloc((max_val + 1) * sizeof(int));
    for (int i = 0; i <= max_val; i++) {
        last_occurrence[i] = -1;
    }

    for (int i = 0; i < numsSize; i++) {
        last_occurrence[nums[i]] = i;
    }

    int partitions = 1;
    int max_index = last_occurrence[nums[0]];
    for (int i = 0; i < numsSize; i++) {
        if (i == max_index) {
            if (i < numsSize - 1) {
                partitions = (partitions * 2) % MOD;
                max_index = last_occurrence[nums[i + 1]];
            }
        } else {
            if (last_occurrence[nums[i]] > max_index) {
                max_index = last_occurrence[nums[i]];
            }
        }
    }

    free(last_occurrence);
    return partitions;
}
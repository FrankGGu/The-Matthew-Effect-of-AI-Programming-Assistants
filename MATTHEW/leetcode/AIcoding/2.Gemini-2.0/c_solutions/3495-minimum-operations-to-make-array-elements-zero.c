#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumOperations(int* nums, int numsSize){
    int operations = 0;
    int max_val = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max_val) {
            max_val = nums[i];
        }
    }

    int present[max_val + 1];
    for (int i = 0; i <= max_val; i++) {
        present[i] = 0;
    }

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0) {
            present[nums[i]] = 1;
        }
    }

    for (int i = 1; i <= max_val; i++) {
        if (present[i] == 1) {
            operations++;
            int current_min = i;
            for (int j = 0; j < numsSize; j++) {
                if (nums[j] > 0) {
                    nums[j] -= current_min;
                }
            }

            max_val = 0;
            for (int j = 0; j < numsSize; j++) {
                if (nums[j] > max_val) {
                    max_val = nums[j];
                }
            }

            for (int k = 0; k <= max_val; k++) {
                present[k] = 0;
            }

            for (int j = 0; j < numsSize; j++) {
                if (nums[j] > 0) {
                    present[nums[j]] = 1;
                }
            }
        }
    }

    return operations;
}
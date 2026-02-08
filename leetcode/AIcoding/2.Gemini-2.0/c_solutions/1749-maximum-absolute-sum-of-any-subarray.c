#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxAbsoluteSum(int* nums, int numsSize) {
    int max_so_far = 0;
    int min_so_far = 0;
    int current_max = 0;
    int current_min = 0;

    for (int i = 0; i < numsSize; i++) {
        current_max = current_max + nums[i];
        if (current_max < 0) {
            current_max = 0;
        }
        if (current_max > max_so_far) {
            max_so_far = current_max;
        }

        current_min = current_min + nums[i];
        if (current_min > 0) {
            current_min = 0;
        }
        if (current_min < min_so_far) {
            min_so_far = current_min;
        }
    }

    return abs(max_so_far) > abs(min_so_far) ? abs(max_so_far) : abs(min_so_far);
}
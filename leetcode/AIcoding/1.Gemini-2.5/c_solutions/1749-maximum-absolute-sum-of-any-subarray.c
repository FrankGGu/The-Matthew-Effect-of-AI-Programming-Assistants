#include <stdlib.h> // For abs

int maximumAbsoluteSum(int* nums, int numsSize) {
    int max_so_far = nums[0];
    int current_max = nums[0];

    int min_so_far = nums[0];
    int current_min = nums[0];

    for (int i = 1; i < numsSize; i++) {
        current_max = (nums[i] > current_max + nums[i]) ? nums[i] : current_max + nums[i];
        max_so_far = (max_so_far > current_max) ? max_so_far : current_max;

        current_min = (nums[i] < current_min + nums[i]) ? nums[i] : current_min + nums[i];
        min_so_far = (min_so_far < current_min) ? min_so_far : current_min;
    }

    return (abs(max_so_far) > abs(min_so_far)) ? abs(max_so_far) : abs(min_so_far);
}
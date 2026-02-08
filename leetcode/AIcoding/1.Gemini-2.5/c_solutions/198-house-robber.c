#include <stdlib.h> // For max

int rob(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }
    if (numsSize == 1) {
        return nums[0];
    }

    int dp_i_minus_2 = nums[0];
    int dp_i_minus_1 = (nums[0] > nums[1]) ? nums[0] : nums[1];

    for (int i = 2; i < numsSize; i++) {
        int current_max = ((dp_i_minus_2 + nums[i]) > dp_i_minus_1) ? (dp_i_minus_2 + nums[i]) : dp_i_minus_1;
        dp_i_minus_2 = dp_i_minus_1;
        dp_i_minus_1 = current_max;
    }

    return dp_i_minus_1;
}
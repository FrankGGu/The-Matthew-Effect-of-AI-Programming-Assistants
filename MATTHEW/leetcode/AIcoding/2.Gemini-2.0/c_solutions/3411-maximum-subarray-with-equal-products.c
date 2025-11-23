#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxProductSubarray(int* nums, int numsSize) {
    int max_so_far = nums[0];
    int max_ending_here = nums[0];
    int min_ending_here = nums[0];

    for (int i = 1; i < numsSize; i++) {
        int temp_max = max_ending_here;
        max_ending_here = (nums[i] > max_ending_here * nums[i] ? nums[i] : max_ending_here * nums[i]);
        max_ending_here = (max_ending_here > min_ending_here * nums[i] ? max_ending_here : min_ending_here * nums[i]);

        min_ending_here = (nums[i] < temp_max * nums[i] ? nums[i] : temp_max * nums[i]);
        min_ending_here = (min_ending_here < min_ending_here * nums[i] ? min_ending_here : min_ending_here * nums[i]);

        max_so_far = (max_so_far > max_ending_here ? max_so_far : max_ending_here);
    }

    return max_so_far;
}
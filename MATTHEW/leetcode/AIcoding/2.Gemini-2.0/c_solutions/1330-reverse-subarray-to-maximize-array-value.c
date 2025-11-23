#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int abs(int x) {
    return x > 0 ? x : -x;
}

int maxValueAfterReverse(int* nums, int numsSize) {
    int sum = 0;
    for (int i = 0; i < numsSize - 1; i++) {
        sum += abs(nums[i] - nums[i + 1]);
    }

    int extra = 0;
    for (int i = 1; i < numsSize - 1; i++) {
        int val1 = abs(nums[0] - nums[i + 1]) - abs(nums[i] - nums[i + 1]);
        int val2 = abs(nums[numsSize - 1] - nums[i - 1]) - abs(nums[i] - nums[i - 1]);
        extra = extra > val1 ? extra : val1;
        extra = extra > val2 ? extra : val2;
    }

    int min_diff = INT_MAX;
    int max_sum = INT_MIN;

    for (int i = 0; i < numsSize - 1; i++) {
        int diff = abs(nums[i] - nums[i + 1]);
        min_diff = min_diff < diff ? min_diff : diff;
        max_sum = max_sum > nums[i] + nums[i + 1] ? max_sum : nums[i] + nums[i + 1];
    }

    int min_sum = INT_MAX;
    for (int i = 0; i < numsSize - 1; i++) {
        min_sum = min_sum < nums[i] + nums[i + 1] ? min_sum : nums[i] + nums[i + 1];
    }

    extra = extra > 2 * (max_sum / 2 - min_sum / 2) ? extra : 2 * (max_sum / 2 - min_sum / 2);

    return sum + extra;
}
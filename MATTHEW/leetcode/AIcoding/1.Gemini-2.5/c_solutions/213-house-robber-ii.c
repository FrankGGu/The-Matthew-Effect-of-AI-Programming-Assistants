#include <stdlib.h> // Required for general utility, though not strictly for this problem's logic itself.

static int rob_linear(int* nums, int start, int end) {
    if (start > end) {
        return 0;
    }
    if (start == end) {
        return nums[start];
    }

    int prev2 = 0; // Represents the maximum amount robbed up to house i-2
    int prev1 = 0; // Represents the maximum amount robbed up to house i-1
    int current_max = 0;

    for (int i = start; i <= end; ++i) {
        // The current maximum is either robbing the current house (nums[i]) plus
        // the max from two houses ago (prev2), or not robbing the current house
        // and taking the max from the previous house (prev1).
        current_max = (prev1 > (prev2 + nums[i])) ? prev1 : (prev2 + nums[i]);
        prev2 = prev1;
        prev1 = current_max;
    }

    return prev1;
}

int rob(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }
    if (numsSize == 1) {
        return nums[0];
    }

    // Case 1: Exclude the last house (nums[numsSize - 1]). Rob houses from 0 to numsSize - 2.
    int result1 = rob_linear(nums, 0, numsSize - 2);

    // Case 2: Exclude the first house (nums[0]). Rob houses from 1 to numsSize - 1.
    int result2 = rob_linear(nums, 1, numsSize - 1);

    // The maximum of these two cases is the answer.
    return (result1 > result2) ? result1 : result2;
}
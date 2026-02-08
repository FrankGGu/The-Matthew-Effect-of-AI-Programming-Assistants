#include <limits.h>

int countElements(int* nums, int numsSize) {
    int min_val = INT_MAX;
    int max_val = INT_MIN;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < min_val) {
            min_val = nums[i];
        }
        if (nums[i] > max_val) {
            max_val = nums[i];
        }
    }

    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > min_val && nums[i] < max_val) {
            count++;
        }
    }

    return count;
}
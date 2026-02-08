#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int maximumScore(int* nums, int numsSize, int k) {
    int left = k;
    int right = k;
    int min_val = nums[k];
    int max_score = nums[k];

    while (left > 0 || right < numsSize - 1) {
        if (left == 0) {
            right++;
            min_val = min(min_val, nums[right]);
        } else if (right == numsSize - 1) {
            left--;
            min_val = min(min_val, nums[left]);
        } else if (nums[left - 1] < nums[right + 1]) {
            right++;
            min_val = min(min_val, nums[right]);
        } else {
            left--;
            min_val = min(min_val, nums[left]);
        }
        max_score = max(max_score, min_val * (right - left + 1));
    }

    return max_score;
}
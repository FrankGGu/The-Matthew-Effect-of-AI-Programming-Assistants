#include <stdbool.h>

bool check(int* nums, int numsSize, int m, int max_sum) {
    int subarrays = 1;
    long long current_sum = 0;
    for (int i = 0; i < numsSize; i++) {
        if (current_sum + nums[i] > max_sum) {
            subarrays++;
            current_sum = nums[i];
        } else {
            current_sum += nums[i];
        }
    }
    return subarrays <= m;
}

int splitArray(int* nums, int numsSize, int m) {
    long long left = 0;
    long long right = 0;

    int max_val = 0;
    for (int i = 0; i < numsSize; i++) {
        right += nums[i];
        if (nums[i] > max_val) {
            max_val = nums[i];
        }
    }
    left = max_val;

    long long ans = right;

    while (left <= right) {
        long long mid = left + (right - left) / 2;
        if (check(nums, numsSize, m, (int)mid)) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }
    return (int)ans;
}
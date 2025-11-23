#include <stdbool.h>

bool check(long long target, int* nums, int numsSize) {
    long long current_prefix_sum = 0;
    for (int i = 0; i < numsSize; ++i) {
        current_prefix_sum += nums[i];
        if (current_prefix_sum > (long long)(i + 1) * target) {
            return false;
        }
    }
    return true;
}

int minimizeArrayValue(int* nums, int numsSize) {
    int low = 0;
    int high = 1000000000; 
    int ans = high;        

    while (low <= high) {
        int mid = low + (high - low) / 2; 

        if (check((long long)mid, nums, numsSize)) {
            ans = mid;         
            high = mid - 1;
        } else {
            low = mid + 1;     
        }
    }

    return ans;
}
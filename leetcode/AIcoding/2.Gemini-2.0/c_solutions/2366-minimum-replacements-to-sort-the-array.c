#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long minimumReplacement(int* nums, int numsSize) {
    long long ans = 0;
    int prev = nums[numsSize - 1];
    for (int i = numsSize - 2; i >= 0; i--) {
        if (nums[i] > prev) {
            int k = (nums[i] + prev - 1) / prev;
            ans += k - 1;
            prev = nums[i] / k;
        } else {
            prev = nums[i];
        }
    }
    return ans;
}
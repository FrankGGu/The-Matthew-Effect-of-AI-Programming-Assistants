#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long min(long long a, long long b) {
    return (a < b) ? a : b;
}

long long abs_long(long long x) {
    return (x < 0) ? -x : x;
}

long long calculate_cost(long long* nums, int numsSize, long long target) {
    long long cost = 0;
    for (int i = 0; i < numsSize; i++) {
        cost += abs_long(nums[i] - target);
    }
    return cost;
}

long long find_min_cost(long long* nums, int numsSize) {
    long long min_val = nums[0];
    long long max_val = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < min_val) min_val = nums[i];
        if (nums[i] > max_val) max_val = nums[i];
    }

    long long min_cost = LLONG_MAX;

    for (long long candidate = min_val; candidate <= max_val; candidate++) {
        long long cost = calculate_cost(nums, numsSize, candidate);
        if (cost < min_cost) {
            min_cost = cost;
        }
    }

    return min_cost;
}

long long makePalindrome(long long* nums, int numsSize) {
    return find_min_cost(nums, numsSize);
}
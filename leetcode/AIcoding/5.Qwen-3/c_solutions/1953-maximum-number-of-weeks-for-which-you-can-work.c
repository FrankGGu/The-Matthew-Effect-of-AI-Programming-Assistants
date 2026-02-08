#include <stdio.h>
#include <stdlib.h>

long long mostBooks(long long* nums, int numsSize) {
    long long sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }
    long long max = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max) {
            max = nums[i];
        }
    }
    if (max > sum - max) {
        return 2 * (sum - max) + 1;
    } else {
        return sum;
    }
}

long long work(int* nums, int numsSize) {
    return mostBooks((long long*)nums, numsSize);
}
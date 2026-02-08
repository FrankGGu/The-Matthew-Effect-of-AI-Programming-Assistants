#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSpecialSubsequences(int* nums, int numsSize) {
    long long mod = 1e9 + 7;
    long long zero = 0;
    long long one = 0;
    long long two = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 0) {
            zero = (2 * zero + 1) % mod;
        } else if (nums[i] == 1) {
            one = (2 * one + zero) % mod;
        } else {
            two = (2 * two + one) % mod;
        }
    }

    return (int)two;
}
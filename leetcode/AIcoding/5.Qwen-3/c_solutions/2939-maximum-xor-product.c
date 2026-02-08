#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

long long maximumXorProduct(long long a, long long b, long long* nums, int numsSize) {
    long long mod = 1000000007;
    for (int i = 0; i < numsSize; i++) {
        long long x = nums[i];
        if (a > b) {
            if ((a ^ x) > a) {
                a ^= x;
            } else {
                b ^= x;
            }
        } else {
            if ((b ^ x) > b) {
                b ^= x;
            } else {
                a ^= x;
            }
        }
    }
    return (a > b ? a : b) % mod;
}
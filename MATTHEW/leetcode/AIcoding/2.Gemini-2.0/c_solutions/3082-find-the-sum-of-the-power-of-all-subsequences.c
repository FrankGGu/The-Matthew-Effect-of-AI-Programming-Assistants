#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int sumPower(int* nums, int numsSize) {
    long long mod = 1e9 + 7;
    long long ans = 0;
    long long pow2 = 1;
    for (int i = 0; i < numsSize; i++) {
        ans = (ans + (long long)nums[i] * nums[i] % mod * pow2 % mod) % mod;
        pow2 = (pow2 * 2) % mod;
    }
    return ans;
}
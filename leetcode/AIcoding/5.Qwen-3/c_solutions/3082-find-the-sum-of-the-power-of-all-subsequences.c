#include <stdio.h>
#include <stdlib.h>

long long sumOfPower(int* nums, int numsSize) {
    long long result = 0;
    long long mod = 1000000007;
    long long* pow2 = (long long*)malloc((numsSize + 1) * sizeof(long long));
    pow2[0] = 1;
    for (int i = 1; i <= numsSize; i++) {
        pow2[i] = (pow2[i - 1] * 2) % mod;
    }
    for (int i = 0; i < numsSize; i++) {
        long long a = nums[i];
        long long power = 1;
        for (int j = i + 1; j < numsSize; j++) {
            power = (power * nums[j]) % mod;
        }
        result = (result + a * power) % mod;
    }
    free(pow2);
    return result;
}
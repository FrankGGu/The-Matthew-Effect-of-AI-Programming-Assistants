#include <math.h>

long long maximumSum(int* nums, int numsSize) {
    long long res = 0;
    for (int i = 1; i <= numsSize; i++) {
        long long cur = 0;
        for (int j = 1; i * j * j <= numsSize; j++) {
            cur += nums[i * j * j - 1];
        }
        if (cur > res) res = cur;
    }
    return res;
}
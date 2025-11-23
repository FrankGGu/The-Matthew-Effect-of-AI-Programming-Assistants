#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimizeArrayValue(int* nums, int numsSize) {
    long long sum = 0;
    long long ans = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
        ans = fmax(ans, (sum + i) / (i + 1));
    }
    return ans;
}
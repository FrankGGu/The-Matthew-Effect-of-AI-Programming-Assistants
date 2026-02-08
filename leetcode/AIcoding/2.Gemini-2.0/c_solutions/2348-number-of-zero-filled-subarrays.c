#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long zeroFilledSubarray(int* nums, int numsSize) {
    long long ans = 0;
    long long count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 0) {
            count++;
        } else {
            ans += (count * (count + 1)) / 2;
            count = 0;
        }
    }
    ans += (count * (count + 1)) / 2;
    return ans;
}
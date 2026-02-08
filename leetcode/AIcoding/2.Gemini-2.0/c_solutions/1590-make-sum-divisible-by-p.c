#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minSubarray(int* nums, int numsSize, int p) {
    int need = 0;
    for (int i = 0; i < numsSize; i++) {
        need = (need + nums[i]) % p;
    }
    if (need == 0) {
        return 0;
    }
    int ans = numsSize;
    int sum = 0;
    int last[p];
    for (int i = 0; i < p; i++) {
        last[i] = -1;
    }
    last[0] = -1;
    for (int i = 0; i < numsSize; i++) {
        sum = (sum + nums[i]) % p;
        int target = (sum - need + p) % p;
        if (last[target] != -1) {
            ans = fmin(ans, i - last[target]);
        }
        last[sum] = i;
    }
    if (ans == numsSize) {
        return -1;
    }
    return ans;
}
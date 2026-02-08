#include <stdio.h>
#include <stdlib.h>

int minOrAfterOperations(int* nums, int numsSize) {
    int mask = 0;
    for (int i = 0; i < numsSize; ++i) {
        mask |= nums[i];
    }
    int result = mask;
    for (int bit = 0; bit < 30; ++bit) {
        int cnt = 0;
        int tempMask = mask;
        for (int i = 0; i < numsSize; ++i) {
            if ((nums[i] & (1 << bit)) == 0) {
                cnt++;
            } else {
                tempMask &= ~((1 << bit));
            }
        }
        if (cnt >= 1) {
            result = tempMask;
            mask = tempMask;
        }
    }
    return result;
}
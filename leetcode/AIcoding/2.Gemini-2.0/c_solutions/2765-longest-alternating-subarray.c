#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int alternatingSubarray(int* nums, int numsSize){
    int maxLen = 1;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            int len = j - i + 1;
            int isValid = 1;
            for (int k = i + 1; k <= j; k++) {
                if (nums[k] - nums[k - 1] != (k - i) % 2 == 0 ? 1 : -1) {
                    isValid = 0;
                    break;
                }
            }
            if (isValid) {
                maxLen = (len > maxLen) ? len : maxLen;
            }
        }
    }
    return (maxLen == 1 && numsSize == 1) ? 1 : (maxLen == 1 && numsSize > 1 && nums[0]==nums[1]) ? -1 : maxLen;
}
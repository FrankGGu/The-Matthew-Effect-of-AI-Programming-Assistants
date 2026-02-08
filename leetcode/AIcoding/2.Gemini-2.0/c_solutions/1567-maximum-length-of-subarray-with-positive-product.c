#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int getMaxLen(int* nums, int numsSize){
    int pos = 0, neg = 0, maxLen = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0) {
            pos++;
            if (neg > 0) {
                neg++;
            }
        } else if (nums[i] < 0) {
            int temp = pos;
            pos = neg;
            neg = temp;
            neg++;
            if (pos > 0) {
                pos++;
            }
        } else {
            pos = 0;
            neg = 0;
        }
        if (pos > maxLen) {
            maxLen = pos;
        }
    }
    return maxLen;
}
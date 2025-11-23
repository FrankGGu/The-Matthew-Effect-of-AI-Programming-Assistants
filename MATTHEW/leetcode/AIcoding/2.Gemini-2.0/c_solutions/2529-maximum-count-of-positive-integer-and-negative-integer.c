#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumCount(int* nums, int numsSize) {
    int pos = 0;
    int neg = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0) {
            pos++;
        } else if (nums[i] < 0) {
            neg++;
        }
    }
    return (pos > neg) ? pos : neg;
}
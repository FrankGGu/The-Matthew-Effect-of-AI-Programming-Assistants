#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findUnsortedSubarray(int* nums, int numsSize) {
    int l = numsSize, r = 0;
    for (int i = 0; i < numsSize - 1; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if (nums[j] < nums[i]) {
                l = l > i ? i : l;
                r = r < j ? j : r;
            }
        }
    }
    return (r - l) < 0 ? 0 : (r - l + 1);
}
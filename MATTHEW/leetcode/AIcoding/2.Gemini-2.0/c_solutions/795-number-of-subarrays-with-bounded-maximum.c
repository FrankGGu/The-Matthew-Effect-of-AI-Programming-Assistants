#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numSubarrayBoundedMax(int* nums, int numsSize, int left, int right) {
    int count = 0;
    int start = -1;
    int end = -1;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] >= left && nums[i] <= right) {
            end = i;
            count += (end - start);
        } else if (nums[i] < left) {
            if (end != -1) {
                count += (end - start);
            }
        } else {
            start = i;
            end = -1;
        }
    }
    return count;
}
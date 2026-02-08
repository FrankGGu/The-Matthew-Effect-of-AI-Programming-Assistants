#include <stdio.h>
#include <stdlib.h>

int minReplacement(int* nums, int numsSize) {
    int result = 0;
    for (int i = numsSize - 1; i > 0; i--) {
        if (nums[i - 1] <= nums[i]) continue;
        int count = 0;
        while (nums[i - 1] > nums[i]) {
            nums[i - 1] = (nums[i - 1] + 1) / 2;
            count++;
        }
        result += count;
    }
    return result;
}
#include <stdio.h>
#include <stdlib.h>

int unsortedArray(int* nums, int numsSize, int k) {
    int i, j, temp;
    for (i = 0; i < numsSize - 1; i++) {
        for (j = 0; j < numsSize - i - 1; j++) {
            if (nums[j] > nums[j + 1]) {
                temp = nums[j];
                nums[j] = nums[j + 1];
                nums[j + 1] = temp;
            }
        }
    }

    int sum = 0;
    int count = 0;
    for (i = numsSize - 1; i >= 0; i--) {
        sum += nums[i];
        count++;
        if (sum >= k) {
            return count;
        }
    }
    return numsSize;
}
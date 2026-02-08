#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countNonDecreasing(int* nums, int numsSize, int k) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        int operations = k;
        int maxVal = nums[i];
        int j = i + 1;
        while (j < numsSize) {
            if (nums[j] >= maxVal) {
                maxVal = nums[j];
                j++;
            } else {
                if (operations > 0) {
                    operations--;
                    maxVal = nums[j];
                    j++;
                } else {
                    break;
                }
            }
        }
        count += (j - i);
    }
    return count;
}
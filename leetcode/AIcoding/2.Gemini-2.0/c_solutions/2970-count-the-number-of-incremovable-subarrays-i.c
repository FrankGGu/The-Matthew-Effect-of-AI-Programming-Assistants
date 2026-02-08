#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countIncremovableSubarrays(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i; j < numsSize; j++) {
            bool removable = true;
            int prev = -1;
            for (int k = 0; k < numsSize; k++) {
                if (k >= i && k <= j) continue;
                if (prev != -1 && nums[k] <= prev) {
                    removable = false;
                    break;
                }
                prev = nums[k];
            }
            if (removable) {
                count++;
            }
        }
    }
    return count;
}
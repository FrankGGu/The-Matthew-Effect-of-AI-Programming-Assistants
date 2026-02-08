#include <stdio.h>
#include <stdlib.h>

int getMinDistance(int* nums, int numsSize, int target, int start) {
    int minDist = abs(nums[0] - target);
    for (int i = 1; i < numsSize; i++) {
        int dist = abs(nums[i] - target);
        if (dist < minDist) {
            minDist = dist;
        }
    }
    return minDist;
}
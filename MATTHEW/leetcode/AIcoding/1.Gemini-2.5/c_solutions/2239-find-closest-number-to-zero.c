#include <stdlib.h>
#include <math.h>

int findClosestNumber(int* nums, int numsSize) {
    int closest = nums[0];
    int minAbsDiff = abs(nums[0]);

    for (int i = 1; i < numsSize; i++) {
        int currentNum = nums[i];
        int currentAbsDiff = abs(currentNum);

        if (currentAbsDiff < minAbsDiff) {
            minAbsDiff = currentAbsDiff;
            closest = currentNum;
        } else if (currentAbsDiff == minAbsDiff) {
            if (currentNum > closest) {
                closest = currentNum;
            }
        }
    }
    return closest;
}
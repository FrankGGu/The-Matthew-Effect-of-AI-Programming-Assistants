#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minSwaps(int* nums, int numsSize){
    int ones = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) {
            ones++;
        }
    }

    int windowOnes = 0;
    for (int i = 0; i < ones; i++) {
        if (nums[i] == 1) {
            windowOnes++;
        }
    }

    int maxOnes = windowOnes;
    for (int i = ones; i < numsSize; i++) {
        if (nums[i] == 1) {
            windowOnes++;
        }
        if (nums[i - ones] == 1) {
            windowOnes--;
        }
        maxOnes = (maxOnes > windowOnes) ? maxOnes : windowOnes;
    }

    return ones - maxOnes;
}
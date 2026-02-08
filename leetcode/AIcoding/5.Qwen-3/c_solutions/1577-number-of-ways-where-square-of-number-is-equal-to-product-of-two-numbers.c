#include <stdio.h>
#include <stdlib.h>

int numTriplets(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        int square = nums[i] * nums[i];
        for (int j = 0; j < numsSize; j++) {
            if (i != j) {
                for (int k = j + 1; k < numsSize; k++) {
                    if (nums[j] * nums[k] == square) {
                        count++;
                    }
                }
            }
        }
    }
    return count;
}
#include <stdio.h>
#include <stdlib.h>

int minMovesToMakeArrayElementsEqual(int* nums, int numsSize) {
    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }
    int moves = 0;
    for (int i = 0; i < numsSize - 1; i++) {
        moves += nums[i];
    }
    return moves;
}
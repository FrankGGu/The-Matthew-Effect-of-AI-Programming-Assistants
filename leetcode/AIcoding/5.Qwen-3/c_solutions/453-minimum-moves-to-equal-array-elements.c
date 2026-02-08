#include <stdio.h>
#include <stdlib.h>

int minMoves(int* nums, int numsSize) {
    if (numsSize == 0) return 0;
    int min = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < min) {
            min = nums[i];
        }
    }
    int moves = 0;
    for (int i = 0; i < numsSize; i++) {
        moves += nums[i] - min;
    }
    return moves;
}
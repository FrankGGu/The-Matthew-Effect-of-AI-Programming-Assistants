#include <stdio.h>
#include <stdlib.h>

bool canWin(int* nums, int start, int end, int turn) {
    if (start == end) {
        return turn * nums[start] >= 0;
    }
    int pickStart = canWin(nums, start + 1, end, -turn);
    int pickEnd = canWin(nums, start, end - 1, -turn);
    return (turn * nums[start] + (pickStart ? 0 : 0)) >= 0 || (turn * nums[end] + (pickEnd ? 0 : 0)) >= 0;
}

bool PredictTheWinner(int* nums, int numsSize) {
    return canWin(nums, 0, numsSize - 1, 1);
}
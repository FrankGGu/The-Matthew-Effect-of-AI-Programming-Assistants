#include <stdio.h>
#include <stdlib.h>

int maximumCount(int* nums, int numsSize) {
    int negative = 0;
    int positive = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < 0) negative++;
        else if (nums[i] > 0) positive++;
    }
    return (negative > positive) ? negative : positive;
}
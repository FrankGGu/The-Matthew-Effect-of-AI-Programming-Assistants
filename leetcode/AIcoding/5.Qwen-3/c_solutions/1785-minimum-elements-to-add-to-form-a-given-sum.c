#include <stdio.h>
#include <stdlib.h>

int minElements(int* nums, int numsSize, int limit, int goal) {
    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }
    int diff = goal - sum;
    if (diff == 0) return 0;
    return (abs(diff) + limit - 1) / limit;
}
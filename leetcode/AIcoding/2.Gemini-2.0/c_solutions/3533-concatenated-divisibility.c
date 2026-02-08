#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool can_arrange(int* nums, int numsSize) {
    long long sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }
    return (sum % 2 == 0);
}
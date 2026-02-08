#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int sumSubarray(int* nums, int numsSize, int k) {
    int sum = 0;
    for (int i = 0; i <= numsSize - k; i++) {
        for (int j = i; j < i + k; j++) {
            sum += nums[j];
        }
    }
    return sum;
}
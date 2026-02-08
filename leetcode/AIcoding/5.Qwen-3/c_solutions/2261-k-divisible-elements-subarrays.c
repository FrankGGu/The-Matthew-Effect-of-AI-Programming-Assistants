#include <stdio.h>
#include <stdlib.h>

int kDivisibleElementsSubarrays(int* nums, int numsSize, int k) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        int current = 0;
        for (int j = i; j < numsSize; j++) {
            current = current * 10 + nums[j];
            if (current % k == 0) {
                count++;
            }
        }
    }
    return count;
}
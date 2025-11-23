#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long maximumTripletValue(int* nums, int numsSize) {
    long long max_val = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            for (int k = j + 1; k < numsSize; k++) {
                long long val = ((long long)nums[i] - (long long)nums[j]) * (long long)nums[k];
                if (val > max_val) {
                    max_val = val;
                }
            }
        }
    }
    return max_val;
}
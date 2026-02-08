#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumTripletValue(int* nums, int numsSize) {
    long long max_value = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            for (int k = j + 1; k < numsSize; k++) {
                long long current_value = ((long long)nums[i] - (long long)nums[j]) * (long long)nums[k];
                if (current_value > max_value) {
                    max_value = current_value;
                }
            }
        }
    }
    return max_value > 0 ? (int)max_value : 0;
}
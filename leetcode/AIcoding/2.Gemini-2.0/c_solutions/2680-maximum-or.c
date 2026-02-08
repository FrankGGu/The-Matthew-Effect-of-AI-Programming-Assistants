#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumOr(int* nums, int numsSize, int k) {
    int maxOr = 0;
    for (int i = 0; i < numsSize; i++) {
        long long temp = (long long)nums[i] << k;
        int currentOr = 0;
        for (int j = 0; j < numsSize; j++) {
            if (i != j) {
                currentOr |= nums[j];
            }
        }
        currentOr |= (int)temp;
        if (currentOr > maxOr) {
            maxOr = currentOr;
        }
    }
    return maxOr;
}
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int countSubsequencesWithEqualGCD(int* nums, int numsSize) {
    int maxGCD = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxGCD) maxGCD = nums[i];
    }

    int* freq = (int*)calloc(maxGCD + 1, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
    }

    int result = 0;
    for (int g = 1; g <= maxGCD; g++) {
        int count = 0;
        for (int i = g; i <= maxGCD; i += g) {
            count += freq[i];
        }
        if (count >= 2) {
            result += (1 << count) - count - 1;
        }
    }

    free(freq);
    return result;
}
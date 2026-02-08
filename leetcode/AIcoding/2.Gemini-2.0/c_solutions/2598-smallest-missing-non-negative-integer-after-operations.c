#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int smallestMissing(int* nums, int numsSize, int value) {
    int* freq = (int*)calloc(value, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        freq[nums[i] % value]++;
    }

    int missing = 0;
    while (1) {
        if (freq[missing % value] > 0) {
            freq[missing % value]--;
            missing++;
        } else {
            free(freq);
            return missing;
        }
    }
}
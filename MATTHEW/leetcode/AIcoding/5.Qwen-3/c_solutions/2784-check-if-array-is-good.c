#include <stdio.h>
#include <stdlib.h>

bool isGood(int* nums, int numsSize) {
    int max = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > max) {
            max = nums[i];
        }
    }
    int* freq = (int*)calloc(max + 1, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
    }
    for (int i = 1; i < max; i++) {
        if (freq[i] != 1) {
            free(freq);
            return false;
        }
    }
    if (freq[max] != 1) {
        free(freq);
        return false;
    }
    free(freq);
    return true;
}
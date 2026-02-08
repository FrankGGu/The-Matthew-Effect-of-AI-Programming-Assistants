#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minChanges(int* nums, int numsSize, int k) {
    int* freq = (int*)calloc(1024, sizeof(int));
    int maxFreq = 0;
    int mode = 0;

    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
        if (freq[nums[i]] > maxFreq) {
            maxFreq = freq[nums[i]];
            mode = nums[i];
        }
    }

    int changes = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] != mode) {
            changes++;
        }
    }

    free(freq);
    return changes;
}
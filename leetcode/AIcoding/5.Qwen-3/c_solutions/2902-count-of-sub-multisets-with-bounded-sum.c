#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int countSubMultisets(int* nums, int numsSize, int maxSum) {
    int* freq = (int*)malloc((maxSum + 1) * sizeof(int));
    for (int i = 0; i <= maxSum; i++) {
        freq[i] = 0;
    }

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 0) continue;
        for (int j = maxSum; j >= nums[i]; j--) {
            freq[j] += freq[j - nums[i]];
        }
    }

    int result = 0;
    for (int i = 0; i <= maxSum; i++) {
        result += freq[i];
    }

    free(freq);
    return result + 1;
}
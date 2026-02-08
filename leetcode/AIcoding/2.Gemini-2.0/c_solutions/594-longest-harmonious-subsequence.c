#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findLHS(int* nums, int numsSize) {
    int *freq = (int*)malloc(sizeof(int) * 20001);
    for (int i = 0; i < 20001; i++) {
        freq[i] = 0;
    }

    for (int i = 0; i < numsSize; i++) {
        freq[nums[i] + 10000]++;
    }

    int max_len = 0;
    for (int i = 1; i < 20001; i++) {
        if (freq[i] > 0 && freq[i - 1] > 0) {
            int len = freq[i] + freq[i - 1];
            if (len > max_len) {
                max_len = len;
            }
        }
    }

    free(freq);
    return max_len;
}
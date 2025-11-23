#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestSquareStreak(int* nums, int numsSize) {
    int max_len = 0;
    int* seen = (int*)calloc(100001, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        seen[nums[i]] = 1;
    }

    for (int i = 0; i < numsSize; i++) {
        int curr = nums[i];
        int len = 1;
        long long next = (long long)curr * curr;
        while (next <= 100000 && seen[(int)next]) {
            len++;
            curr = (int)next;
            next = (long long)curr * curr;
        }
        if (len > max_len) {
            max_len = len;
        }
    }
    free(seen);
    return (max_len > 1) ? max_len : -1;
}
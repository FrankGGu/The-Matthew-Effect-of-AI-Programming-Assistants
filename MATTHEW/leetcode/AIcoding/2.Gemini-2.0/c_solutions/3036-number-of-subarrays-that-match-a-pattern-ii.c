#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int match(int* nums, int numsSize, int* pattern, int patternSize) {
    int n = numsSize, m = patternSize;
    int* s = (int*)malloc(sizeof(int) * n);
    for (int i = 0; i < n - 1; i++) {
        if (nums[i] < nums[i + 1]) s[i] = 1;
        else if (nums[i] > nums[i + 1]) s[i] = -1;
        else s[i] = 0;
    }

    int count = 0;
    for (int i = 0; i <= n - m; i++) {
        int flag = 1;
        for (int j = 0; j < m; j++) {
            if (s[i + j] != pattern[j]) {
                flag = 0;
                break;
            }
        }
        if (flag) count++;
    }
    free(s);
    return count;
}

int countMatchingSubarrays(int* nums, int numsSize, int* pattern, int patternSize) {
    return match(nums, numsSize - 1, pattern, patternSize);
}
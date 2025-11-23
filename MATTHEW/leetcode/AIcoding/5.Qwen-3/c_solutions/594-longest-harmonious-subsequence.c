#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int findXor(int* nums, int numsSize, int x) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        if ((nums[i] ^ x) == 0) {
            count++;
        }
    }
    return count;
}

int findLHS(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);
    int maxLen = 0;
    for (int i = 0; i < numsSize; i++) {
        int j = i + 1;
        while (j < numsSize && nums[j] - nums[i] <= 1) {
            if (nums[j] - nums[i] == 1) {
                int len = j - i + 1;
                if (len > maxLen) {
                    maxLen = len;
                }
            }
            j++;
        }
    }
    return maxLen;
}
#include <stdio.h>
#include <stdlib.h>

int arrayNesting(int nums[], int numsSize) {
    int maxLen = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == -1) continue;
        int start = i;
        int len = 0;
        while (nums[start] != -1) {
            int next = nums[start];
            nums[start] = -1;
            start = next;
            len++;
        }
        maxLen = (len > maxLen) ? len : maxLen;
    }
    return maxLen;
}
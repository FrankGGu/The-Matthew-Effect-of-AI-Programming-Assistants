#include <stdio.h>
#include <stdlib.h>

int findMaxLength(int* nums, int numsSize) {
    int* map = (int*)malloc(sizeof(int) * (numsSize + 1));
    for (int i = 0; i < numsSize + 1; i++) {
        map[i] = -1;
    }
    int maxLen = 0;
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 0) {
            count--;
        } else {
            count++;
        }
        if (map[count] != -1) {
            maxLen = (i - map[count]) > maxLen ? (i - map[count]) : maxLen;
        } else {
            map[count] = i;
        }
    }
    free(map);
    return maxLen;
}
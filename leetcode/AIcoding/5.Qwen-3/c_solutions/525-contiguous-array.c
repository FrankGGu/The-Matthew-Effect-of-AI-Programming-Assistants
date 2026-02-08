#include <stdio.h>
#include <stdlib.h>

int findMaxLength(int* nums, int numsSize) {
    int* hash = (int*)malloc(sizeof(int) * (numsSize + 1));
    for (int i = 0; i <= numsSize; i++) {
        hash[i] = -1;
    }
    int max_len = 0;
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        count += (nums[i] == 0 ? -1 : 1);
        if (hash[count] != -1) {
            max_len = (i - hash[count]) > max_len ? (i - hash[count]) : max_len;
        } else {
            hash[count] = i;
        }
    }
    free(hash);
    return max_len;
}
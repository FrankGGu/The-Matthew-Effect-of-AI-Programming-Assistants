#include <stdio.h>
#include <stdlib.h>

int minimumOperations(int* nums, int numsSize) {
    int* seen = (int*)calloc(101, sizeof(int));
    int count = 0;
    int result = 0;
    for (int i = numsSize - 1; i >= 0; i--) {
        if (seen[nums[i]] == 0) {
            seen[nums[i]] = 1;
            count++;
        }
        if (count == 101) break;
        result++;
    }
    free(seen);
    return result;
}
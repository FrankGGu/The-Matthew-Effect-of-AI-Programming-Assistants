#include <stdio.h>
#include <stdlib.h>

int inventoryManagement(int* nums, int numsSize) {
    int* hash = (int*)calloc(10000, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        hash[nums[i]]++;
    }
    for (int i = 0; i < numsSize; i++) {
        if (hash[nums[i]] == 1) {
            free(hash);
            return nums[i];
        }
    }
    free(hash);
    return -1;
}
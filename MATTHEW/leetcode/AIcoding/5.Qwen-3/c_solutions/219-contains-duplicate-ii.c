#include <stdio.h>
#include <stdlib.h>

bool containsNearbyDuplicate(int* nums, int numsSize, int k) {
    int* hash = (int*)malloc(sizeof(int) * 10000);
    for (int i = 0; i < numsSize; i++) {
        int key = nums[i] % 10000;
        if (hash[key] != 0 && i - hash[key] <= k) {
            free(hash);
            return true;
        }
        hash[key] = i + 1;
    }
    free(hash);
    return false;
}
#include <stdio.h>
#include <stdlib.h>

int countPairs(int* nums, int numsSize, int low, int high) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if ((nums[i] ^ nums[j]) >= low && (nums[i] ^ nums[j]) <= high) {
                count++;
            }
        }
    }
    return count;
}
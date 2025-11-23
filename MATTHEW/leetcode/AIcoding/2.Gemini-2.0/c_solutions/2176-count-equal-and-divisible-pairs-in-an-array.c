#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countPairs(int* nums, int numsSize, int k){
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if (nums[i] == nums[j] && (i * j) % k == 0) {
                count++;
            }
        }
    }
    return count;
}
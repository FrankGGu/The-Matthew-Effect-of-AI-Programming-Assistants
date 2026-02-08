#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}

int findPairs(int* nums, int numsSize, int k){
    qsort(nums, numsSize, sizeof(int), cmpfunc);
    int count = 0;
    int i, j;
    for (i = 0; i < numsSize; i++) {
        if (i > 0 && nums[i] == nums[i - 1]) continue;
        for (j = i + 1; j < numsSize; j++) {
            if (nums[j] - nums[i] == k) {
                count++;
                break;
            } else if (nums[j] - nums[i] > k) {
                break;
            }
        }
    }
    return count;
}
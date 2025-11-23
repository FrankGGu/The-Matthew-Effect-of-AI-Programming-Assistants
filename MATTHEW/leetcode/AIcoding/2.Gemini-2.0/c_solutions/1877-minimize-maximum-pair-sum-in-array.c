#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}

int minPairSum(int* nums, int numsSize){
    qsort(nums, numsSize, sizeof(int), cmpfunc);
    int max_sum = 0;
    for (int i = 0; i < numsSize / 2; i++) {
        int current_sum = nums[i] + nums[numsSize - 1 - i];
        if (current_sum > max_sum) {
            max_sum = current_sum;
        }
    }
    return max_sum;
}
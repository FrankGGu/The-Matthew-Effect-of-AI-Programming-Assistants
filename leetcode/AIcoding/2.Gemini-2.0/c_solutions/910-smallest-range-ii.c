#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}

int smallestRangeII(int* nums, int numsSize, int k){
    qsort(nums, numsSize, sizeof(int), cmpfunc);
    int min_val = nums[0];
    int max_val = nums[numsSize - 1];
    int res = max_val - min_val;
    for (int i = 0; i < numsSize - 1; i++) {
        int high = nums[numsSize - 1] - k;
        int low = nums[0] + k;
        int a = nums[i] + k;
        int b = nums[i + 1] - k;
        int cur_max = (high > a) ? high : a;
        int cur_min = (low < b) ? low : b;
        res = (res < (cur_max - cur_min)) ? res : (cur_max - cur_min);
    }
    return res;
}
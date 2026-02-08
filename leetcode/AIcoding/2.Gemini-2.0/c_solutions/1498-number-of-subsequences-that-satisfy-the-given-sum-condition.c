#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numSubseq(int* nums, int numsSize, int target){
    int MOD = 1000000007;
    int count = 0;
    int left = 0;
    int right = numsSize - 1;
    int power[numsSize];
    power[0] = 1;
    for (int i = 1; i < numsSize; i++) {
        power[i] = (power[i - 1] * 2) % MOD;
    }

    qsort(nums, numsSize, sizeof(int), (int (*)(const void *, const void *))cmpfunc);

    while (left <= right) {
        if (nums[left] + nums[right] > target) {
            right--;
        } else {
            count = (count + power[right - left]) % MOD;
            left++;
        }
    }

    return count;
}

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}
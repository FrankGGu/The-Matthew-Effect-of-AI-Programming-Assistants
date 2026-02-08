#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}

int maxFrequency(int* nums, int numsSize, int k){
    qsort(nums, numsSize, sizeof(int), cmpfunc);
    int left = 0, right = 0;
    long long sum = 0;
    int maxFreq = 0;

    while (right < numsSize) {
        sum += nums[right];

        while ((long long)nums[right] * (right - left + 1) > sum + k) {
            sum -= nums[left];
            left++;
        }

        maxFreq = (maxFreq > (right - left + 1)) ? maxFreq : (right - left + 1);
        right++;
    }

    return maxFreq;
}
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int subarraysDivByK(int* nums, int numsSize, int k){
    int count = 0;
    int prefixSum = 0;
    int remainder[k];
    for(int i = 0; i < k; i++)
    {
        remainder[i] = 0;
    }
    remainder[0] = 1;

    for(int i = 0; i < numsSize; i++)
    {
        prefixSum += nums[i];
        int mod = (prefixSum % k + k) % k;
        count += remainder[mod];
        remainder[mod]++;
    }

    return count;
}
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int sumOfPower(int* nums, int numsSize){
    long long mod = 1e9 + 7;
    long long ans = 0;
    long long sum = 0;

    qsort(nums, numsSize, sizeof(int), (int (*)(const void *,const void *))cmpfunc);

    for(int i = 0; i < numsSize; i++){
        ans = (ans + (long long)nums[i] * ((long long)nums[i] % mod) % mod * ((long long)nums[i] % mod) % mod + (long long)nums[i] * ((long long)sum % mod) % mod * ((long long)nums[i] % mod) % mod) % mod;
        sum = (sum * 2 % mod + nums[i]) % mod;
    }

    return ans;
}

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}
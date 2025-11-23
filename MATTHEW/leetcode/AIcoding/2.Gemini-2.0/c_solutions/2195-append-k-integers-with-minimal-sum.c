#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}

long long minimalKSum(int* nums, int numsSize, int k){
    qsort(nums, numsSize, sizeof(int), cmpfunc);
    long long sum = 0;
    long long last = 0;
    for(int i = 0; i < numsSize; i++){
        if(nums[i] <= last) continue;
        long long diff = nums[i] - last - 1;
        if(k > 0){
            long long take = (k < diff) ? k : diff;
            sum += ((last + 1) + (last + take)) * take / 2;
            k -= take;
            last = nums[i];
        } else {
            break;
        }
    }
    if(k > 0){
        sum += ((last + 1) + (last + k)) * k / 2;
    }
    return sum;
}
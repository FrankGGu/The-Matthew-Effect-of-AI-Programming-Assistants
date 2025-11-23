#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximizeSum(int* nums, int numsSize, int k){
    int pos = 0, neg = 0, zero = 0;
    for(int i = 0; i < numsSize; i++){
        if(nums[i] > 0) pos++;
        else if(nums[i] < 0) neg++;
        else zero++;
    }
    if(k <= pos) return k;
    else{
        int sum = pos;
        k -= pos;
        if(k <= zero) return sum;
        else{
            k -= zero;
            return sum - k;
        }
    }
}
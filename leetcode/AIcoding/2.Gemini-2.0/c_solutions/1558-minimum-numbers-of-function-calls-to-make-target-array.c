#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minOperations(int* nums, int numsSize){
    int ans = 0;
    int max_bits = 0;
    for(int i = 0; i < numsSize; i++){
        int bits = 0;
        int temp = nums[i];
        while(temp > 0){
            if(temp % 2 == 1){
                ans++;
            }
            temp /= 2;
            bits++;
        }
        if(bits > max_bits){
            max_bits = bits;
        }
    }
    ans += (max_bits - 1);
    return ans;
}
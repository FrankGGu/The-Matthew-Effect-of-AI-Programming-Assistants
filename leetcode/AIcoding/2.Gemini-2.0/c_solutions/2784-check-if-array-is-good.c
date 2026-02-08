#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isGood(int* nums, int numsSize){
    int max = 0;
    int count = 0;
    int freq[201] = {0};
    for(int i = 0; i < numsSize; i++){
        freq[nums[i]]++;
        if(nums[i] > max){
            max = nums[i];
        }
    }
    if(freq[max] != 2){
        return false;
    }
    for(int i = 1; i < max; i++){
        if(freq[i] != 1){
            return false;
        }
    }
    if(max != numsSize - 1){
        return false;
    }
    return true;
}
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* decompressRLElist(int* nums, int numsSize, int* returnSize){
    int size = 0;
    for(int i = 0; i < numsSize; i += 2){
        size += nums[i];
    }

    int *result = (int*)malloc(sizeof(int) * size);
    *returnSize = size;

    int index = 0;
    for(int i = 0; i < numsSize; i += 2){
        int freq = nums[i];
        int val = nums[i+1];

        for(int j = 0; j < freq; j++){
            result[index++] = val;
        }
    }

    return result;
}
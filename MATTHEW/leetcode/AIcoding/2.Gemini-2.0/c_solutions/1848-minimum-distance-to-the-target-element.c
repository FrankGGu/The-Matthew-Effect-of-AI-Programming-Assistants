#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int min(int a, int b) {
    return (a < b) ? a : b;
}

int getMinDistance(int* nums, int numsSize, int target, int start){
    int min_dist = numsSize;
    for(int i = 0; i < numsSize; i++){
        if(nums[i] == target){
            min_dist = min(min_dist, abs(i - start));
        }
    }
    return min_dist;
}
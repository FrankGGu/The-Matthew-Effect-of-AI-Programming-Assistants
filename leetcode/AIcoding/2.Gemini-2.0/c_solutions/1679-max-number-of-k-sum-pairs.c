#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxOperations(int* nums, int numsSize, int k){
    int count = 0;
    int *seen = (int*)malloc(sizeof(int) * numsSize);
    for(int i = 0; i < numsSize; i++) seen[i] = 0;

    for(int i = 0; i < numsSize; i++){
        if(seen[i]) continue;
        for(int j = i + 1; j < numsSize; j++){
            if(seen[j]) continue;
            if(nums[i] + nums[j] == k){
                count++;
                seen[i] = 1;
                seen[j] = 1;
                break;
            }
        }
    }
    free(seen);
    return count;
}
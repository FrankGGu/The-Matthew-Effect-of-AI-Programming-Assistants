#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* distinctDifferenceArray(int* nums, int numsSize, int* returnSize){
    int *result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = numsSize;

    for(int i = 0; i < numsSize; i++){
        int prefix_distinct = 0;
        int suffix_distinct = 0;

        int prefix_counts[201] = {0};
        int suffix_counts[201] = {0};

        for(int j = 0; j <= i; j++){
            if(prefix_counts[nums[j] + 100] == 0){
                prefix_distinct++;
            }
            prefix_counts[nums[j] + 100]++;
        }

        for(int j = i + 1; j < numsSize; j++){
            if(suffix_counts[nums[j] + 100] == 0){
                suffix_distinct++;
            }
            suffix_counts[nums[j] + 100]++;
        }

        result[i] = prefix_distinct - suffix_distinct;
    }

    return result;
}
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* smallestSubarrays(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = numsSize;

    for (int i = 0; i < numsSize; i++) {
        int or_val = nums[i];
        int max_len = 1;
        for (int j = i + 1; j < numsSize; j++) {
            or_val |= nums[j];
            if (or_val == (or_val | nums[j]))
            {
                continue;
            }
            else
            {
                or_val = 0;
                for(int k = i; k <=j;k++)
                    or_val |= nums[k];
                max_len = j - i + 1;
            }

        }
        int or_val_final = 0;
        for(int k = i; k < numsSize; k++)
            or_val_final |= nums[k];

        int temp_len = 1;
        for(int j = i + 1; j < numsSize; j++)
        {
            int or_temp = 0;
            for(int k = i; k <=j; k++)
                or_temp |= nums[k];

            if(or_temp == or_val_final)
                temp_len = j-i+1;
        }
        max_len = temp_len;

        result[i] = max_len;
    }

    return result;
}
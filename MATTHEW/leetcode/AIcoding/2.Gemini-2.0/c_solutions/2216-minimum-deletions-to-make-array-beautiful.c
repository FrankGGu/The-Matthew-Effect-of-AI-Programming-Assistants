#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minDeletion(int* nums, int numsSize){
    int deletions = 0;
    int i = 0;
    while (i < numsSize - deletions - 1) {
        if (nums[i] == nums[i + 1]) {

            int j = i + 1;

            while(j < numsSize){
                nums[j] = nums[j+1];
                j++;
            }

            deletions++;
        } else {
            i += 2;
        }
    }

    if((numsSize - deletions) % 2 != 0){
        deletions++;
    }

    return deletions;
}
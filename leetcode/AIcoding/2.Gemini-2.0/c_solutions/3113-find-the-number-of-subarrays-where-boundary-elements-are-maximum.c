#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSubarrays(int* nums, int numsSize, int k){
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i; j < numsSize; j++) {
            int max_val = nums[i];
            for (int l = i; l <= j; l++) {
                if (nums[l] > max_val) {
                    max_val = nums[l];
                }
            }
            if (nums[i] == max_val && nums[j] == max_val) {
                count++;
            }
        }
    }
    return count;
}
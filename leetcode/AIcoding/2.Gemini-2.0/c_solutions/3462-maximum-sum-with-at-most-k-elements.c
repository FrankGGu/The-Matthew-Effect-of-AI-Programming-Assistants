#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxKSum(int* nums, int numsSize, int k) {
    int max_sum = 0;
    int temp;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if (nums[i] < nums[j]) {
                temp = nums[i];
                nums[i] = nums[j];
                nums[j] = temp;
            }
        }
    }

    for(int i=0; i<numsSize && i<k; i++){
        max_sum += nums[i];
    }

    return max_sum;
}
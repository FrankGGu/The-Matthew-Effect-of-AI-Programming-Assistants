#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumSum(int* nums, int numsSize, int removed) {
    int maxSum = INT_MIN;
    for (int i = 0; i < numsSize; i++) {
        int currentSum = 0;
        for (int j = i; j < numsSize; j++) {
            if (nums[j] != removed) {
                currentSum += nums[j];
                if (currentSum > maxSum) {
                    maxSum = currentSum;
                }
            }
        }
    }

    if (maxSum == INT_MIN) {
        maxSum = 0;
        int allRemoved = 1;
        for(int i = 0; i < numsSize; i++){
            if(nums[i] != removed){
                allRemoved = 0;
                break;
            }
        }

        if (allRemoved) return 0;

        maxSum = INT_MIN;
        for(int i = 0; i < numsSize; i++){
            if(nums[i] > maxSum && nums[i] != removed){
                maxSum = nums[i];
            }
        }
        if(maxSum == INT_MIN) maxSum = 0;
    }

    int totalSum = 0;
    int hasNonRemoved = 0;
    for(int i = 0; i < numsSize; i++){
        if(nums[i] != removed){
            totalSum += nums[i];
            hasNonRemoved = 1;
        }
    }

    if(!hasNonRemoved) return 0;

    return maxSum;
}
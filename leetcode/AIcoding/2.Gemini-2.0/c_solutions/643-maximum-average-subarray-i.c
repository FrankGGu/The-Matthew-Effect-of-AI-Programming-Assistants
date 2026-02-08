#include <stdio.h>
#include <stdlib.h>
#include <string.h>

double findMaxAverage(int* nums, int numsSize, int k){
    double sum = 0;
    for (int i = 0; i < k; i++) {
        sum += nums[i];
    }
    double max_sum = sum;
    for (int i = k; i < numsSize; i++) {
        sum += nums[i] - nums[i - k];
        if (sum > max_sum) {
            max_sum = sum;
        }
    }
    return max_sum / k;
}
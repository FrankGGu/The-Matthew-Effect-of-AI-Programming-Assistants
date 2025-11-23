#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int sumDigits(int num) {
    int sum = 0;
    while (num > 0) {
        sum += num % 10;
        num /= 10;
    }
    return sum;
}

int maxSum(int* nums, int numsSize) {
    int maxSum = -1;
    int* sumMap = (int*)malloc(sizeof(int) * 82);
    for (int i = 0; i < 82; i++) {
        sumMap[i] = -1;
    }

    for (int i = 0; i < numsSize; i++) {
        int sum = sumDigits(nums[i]);
        if (sumMap[sum] != -1) {
            if (nums[i] + sumMap[sum] > maxSum) {
                maxSum = nums[i] + sumMap[sum];
            }
            if (nums[i] > sumMap[sum]) {
                sumMap[sum] = nums[i];
            }
        } else {
            sumMap[sum] = nums[i];
        }
    }

    free(sumMap);
    return maxSum;
}
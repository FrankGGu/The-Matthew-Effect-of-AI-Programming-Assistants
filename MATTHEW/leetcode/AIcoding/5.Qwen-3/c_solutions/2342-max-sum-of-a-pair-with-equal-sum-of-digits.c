#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int getDigitSum(int num) {
    int sum = 0;
    while (num > 0) {
        sum += num % 10;
        num /= 10;
    }
    return sum;
}

int maximumPairSum(int* nums, int numsSize) {
    int maxSum = -1;
    int* digitSums = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        digitSums[i] = getDigitSum(nums[i]);
    }

    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if (digitSums[i] == digitSums[j]) {
                int currentSum = nums[i] + nums[j];
                if (currentSum > maxSum) {
                    maxSum = currentSum;
                }
            }
        }
    }

    free(digitSums);
    return maxSum;
}
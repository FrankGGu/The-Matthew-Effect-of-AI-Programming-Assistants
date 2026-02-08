#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int waysToPartition(int* nums, int numsSize, int k) {
    long long totalSum = 0;
    for (int i = 0; i < numsSize; i++) {
        totalSum += nums[i];
    }

    int count = 0;
    if (totalSum % 2 == 0) {
        long long target = totalSum / 2;
        long long currentSum = 0;
        for (int i = 0; i < numsSize - 1; i++) {
            currentSum += nums[i];
            if (currentSum == target) {
                count++;
            }
        }
    }

    int result = 0;
    for (int i = 0; i < numsSize; i++) {
        int originalValue = nums[i];
        nums[i] = k;
        long long newTotalSum = totalSum - originalValue + k;
        int tempCount = 0;

        if (newTotalSum % 2 == 0) {
            long long newTarget = newTotalSum / 2;
            long long currentSum = 0;
            for (int j = 0; j < numsSize - 1; j++) {
                currentSum += nums[j];
                if (currentSum == newTarget) {
                    tempCount++;
                }
            }
        }

        result = (result > tempCount) ? result : tempCount;
        nums[i] = originalValue;
    }

    return (result > count) ? result : count;
}
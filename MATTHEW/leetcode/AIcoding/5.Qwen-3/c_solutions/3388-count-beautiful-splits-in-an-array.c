#include <stdio.h>
#include <stdlib.h>

int countBeautifulSplits(int* nums, int numsSize) {
    int count = 0;
    for (int i = 1; i < numsSize - 1; i++) {
        int leftSum = 0;
        for (int j = 0; j < i; j++) {
            leftSum += nums[j];
        }
        int rightSum = 0;
        for (int j = i + 1; j < numsSize; j++) {
            rightSum += nums[j];
        }
        if (leftSum != rightSum) {
            count++;
        }
    }
    return count;
}
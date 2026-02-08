#include <stdio.h>
#include <stdlib.h>

int differenceBetweenElementSum(int* nums, int numsSize) {
    int elementSum = 0;
    int digitSum = 0;

    for (int i = 0; i < numsSize; i++) {
        elementSum += nums[i];
        int num = nums[i];
        while (num > 0) {
            digitSum += num % 10;
            num /= 10;
        }
    }

    return elementSum - digitSum;
}
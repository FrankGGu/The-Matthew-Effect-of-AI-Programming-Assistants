#include <stdio.h>
#include <stdlib.h>

int differenceOfSums(int nums[], int numsSize, int k) {
    int sumDivisible = 0;
    int sumNonDivisible = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % k == 0) {
            sumDivisible += nums[i];
        } else {
            sumNonDivisible += nums[i];
        }
    }
    return sumNonDivisible - sumDivisible;
}
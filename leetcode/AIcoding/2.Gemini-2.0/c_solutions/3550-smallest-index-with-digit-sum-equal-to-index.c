#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int digitSum(int n) {
    int sum = 0;
    while (n > 0) {
        sum += n % 10;
        n /= 10;
    }
    return sum;
}

int smallestEqual(int* nums, int numsSize) {
    for (int i = 0; i < numsSize; i++) {
        if (i % 10 == nums[i]) {
            return i;
        }
    }
    return -1;
}
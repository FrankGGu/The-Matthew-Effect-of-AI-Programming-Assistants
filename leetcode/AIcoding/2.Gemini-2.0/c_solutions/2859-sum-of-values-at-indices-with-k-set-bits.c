#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSetBits(int n) {
    int count = 0;
    while (n > 0) {
        n &= (n - 1);
        count++;
    }
    return count;
}

int sumIndicesWithKSetBits(int* nums, int numsSize, int k){
    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        if (countSetBits(i) == k) {
            sum += nums[i];
        }
    }
    return sum;
}
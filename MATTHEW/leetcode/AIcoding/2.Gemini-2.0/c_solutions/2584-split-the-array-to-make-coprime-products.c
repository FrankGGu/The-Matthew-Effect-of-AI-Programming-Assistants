#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int gcd(int a, int b) {
    while (b) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

bool canSplitArray(int* nums, int numsSize) {
    if (numsSize == 1) return false;
    for (int i = 0; i < numsSize - 1; i++) {
        int leftProduct = nums[0];
        for (int j = 1; j <= i; j++) {
            leftProduct = leftProduct * nums[j];
        }

        int rightProduct = nums[i + 1];
        for (int j = i + 2; j < numsSize; j++) {
            rightProduct = rightProduct * nums[j];
        }

        if (gcd(leftProduct, rightProduct) == 1) {
            return true;
        }
    }
    return false;
}
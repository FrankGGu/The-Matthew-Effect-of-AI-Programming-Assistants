#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int gcd(int a, int b) {
    if (b == 0) {
        return a;
    }
    return gcd(b, a % b);
}

int subarrayGCD(int* nums, int numsSize, int k) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        int currentGCD = 0;
        for (int j = i; j < numsSize; j++) {
            if (currentGCD == 0) {
                currentGCD = nums[j];
            } else {
                currentGCD = gcd(currentGCD, nums[j]);
            }
            if (currentGCD == k) {
                count++;
            }
        }
    }
    return count;
}
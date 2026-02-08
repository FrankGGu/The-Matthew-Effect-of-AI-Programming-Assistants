#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int gcd(int a, int b) {
    if (b == 0) {
        return a;
    }
    return gcd(b, a % b);
}

bool isGoodArray(int* nums, int numsSize){
    int result = nums[0];
    for (int i = 1; i < numsSize; i++) {
        result = gcd(result, nums[i]);
    }
    return result == 1;
}
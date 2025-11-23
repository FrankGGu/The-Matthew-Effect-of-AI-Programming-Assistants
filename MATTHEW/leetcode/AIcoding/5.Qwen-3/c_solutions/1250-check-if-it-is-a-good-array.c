#include <stdio.h>
#include <stdlib.h>

int gcd(int a, int b) {
    while (b) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int isGoodArray(int* nums, int numsSize) {
    int g = nums[0];
    for (int i = 1; i < numsSize; i++) {
        g = gcd(g, nums[i]);
        if (g == 1) break;
    }
    return g == 1;
}
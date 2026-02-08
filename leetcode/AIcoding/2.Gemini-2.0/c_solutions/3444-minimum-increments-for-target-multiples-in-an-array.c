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

int minIncrements(int n, int nums[], int numsSize) {
    int target = n;
    for (int i = 0; i < numsSize; i++) {
        target = gcd(target, nums[i]);
    }
    return n - target;
}
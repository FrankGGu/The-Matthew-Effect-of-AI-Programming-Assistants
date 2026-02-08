#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int gcd(int a, int b) {
    if (b == 0) {
        return a;
    }
    return gcd(b, a % b);
}

int lcm(int a, int b) {
    return (a * b) / gcd(a, b);
}

int subarrayLCM(int* nums, int numsSize, int k) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        int current_lcm = 1;
        for (int j = i; j < numsSize; j++) {
            current_lcm = lcm(current_lcm, nums[j]);
            if (current_lcm == k) {
                count++;
            } else if (current_lcm > k) {
                break;
            }
        }
    }
    return count;
}
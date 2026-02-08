#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int numberOfSubarraysWithGCD(int* nums, int numsSize, int k) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        int current_gcd = nums[i];
        if (current_gcd == k) count++;
        for (int j = i + 1; j < numsSize; j++) {
            current_gcd = __gcd(current_gcd, nums[j]);
            if (current_gcd == k) count++;
            else if (current_gcd < k) break;
        }
    }
    return count;
}
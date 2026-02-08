#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long maxAlternatingSubarrayCost(int* nums, int numsSize) {
    long long even = nums[0];
    long long odd = -1e10;
    for (int i = 1; i < numsSize; i++) {
        long long newEven = fmax(even, odd + nums[i]);
        long long newOdd = fmax(odd, even - nums[i]);
        even = newEven;
        odd = newOdd;
    }
    return even;
}
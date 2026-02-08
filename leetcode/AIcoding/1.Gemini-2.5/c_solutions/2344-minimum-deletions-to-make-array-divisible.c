#include <stdlib.h> // Required for qsort
#include <stdio.h>  // Not strictly needed for the solution, but common for C

int gcd(int a, int b) {
    while (b) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int compareIntegers(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int minOperations(int* nums, int numsSize, int* nums_divisor, int nums_divisorSize) {
    // Step 1: Calculate the greatest common divisor (GCD) of all elements in nums_divisor.
    int commonDivisor = nums_divisor[0];
    for (int i = 1; i < nums_divisorSize; i++) {
        commonDivisor = gcd(commonDivisor, nums_divisor[i]);
    }

    // Step 2: Sort the nums array in ascending order.
    qsort(nums, numsSize, sizeof(int), compareIntegers);

    // Step 3: Iterate through the sorted nums array to find the smallest element
    // that divides the commonDivisor.
    for (int i = 0; i < numsSize; i++) {
        if (commonDivisor % nums[i] == 0) {
            // If nums[i] divides commonDivisor, it's the smallest such element.
            // The number of deletions required is 'i' (elements before nums[i]).
            return i;
        }
    }

    // Step 4: If no element in nums divides the commonDivisor, it's impossible.
    return -1;
}
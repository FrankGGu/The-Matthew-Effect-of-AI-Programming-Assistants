#include <stdlib.h>

int countDigits(int n) {
    if (n == 0) {
        return 1;
    }
    int count = 0;
    // Assuming n is non-negative as per typical problem constraints for concatenation
    while (n > 0) {
        n /= 10;
        count++;
    }
    return count;
}

int concatenatedDivisibility(int* nums, int numsSize, int k) {
    long long count = 0;

    // Precompute powers of 10 modulo k.
    // An int can have up to 10 digits (e.g., 2,147,483,647).
    // powersOf10ModK[i] will store (10^i) % k.
    long long powersOf10ModK[11]; // Max index needed is 10 for 10 digits
    powersOf10ModK[0] = 1 % k; // 10^0 = 1

    for (int i = 1; i <= 10; ++i) {
        powersOf10ModK[i] = (powersOf10ModK[i-1] * 10) % k;
    }

    // Iterate through all possible pairs (nums[i], nums[j])
    for (int i = 0; i < numsSize; ++i) {
        for (int j = 0; j < numsSize; ++j) {
            int num1 = nums[i];
            int num2 = nums[j];

            // Determine the number of digits in num2.
            // This tells us by what power of 10 num1 needs to be multiplied.
            int digits_num2 = countDigits(num2);

            // Calculate (num1 * 10^digits_num2 + num2) % k
            // Using modular arithmetic properties:
            // (A * B + C) % K = ((A % K) * (B % K) + (C % K)) % K
            // We use long long for intermediate products to prevent overflow before taking modulo.
            long long term1 = ((long long)num1 * powersOf10ModK[digits_num2]) % k;
            long long term2 = num2 % k;

            // Check if the concatenated number is divisible by k
            if ((term1 + term2) % k == 0) {
                count++;
            }
        }
    }

    return (int)count;
}
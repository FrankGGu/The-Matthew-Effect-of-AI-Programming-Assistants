#include <stdlib.h> // Required for malloc

#define MOD 1000000007

long long power(long long base, int exp) {
    long long res = 1;
    base %= MOD; // Ensure base is within modulo range
    while (exp > 0) {
        if (exp % 2 == 1) { // If exp is odd, multiply res by base
            res = (res * base) % MOD;
        }
        base = (base * base) % MOD; // Square the base
        exp /= 2; // Halve the exponent
    }
    return res;
}

int* finalArrayState(int* nums, int numsSize, int k, int* returnSize) {
    // Calculate the total multiplier.
    // Assuming each operation consists of multiplying all elements by 2.
    // This is a common interpretation for "K Multiplication Operations I"
    // when the specific operation's base is not explicitly provided.
    long long total_multiplier = power(2, k);

    // Allocate memory for the result array
    int* result = (int*)malloc(sizeof(int) * numsSize);
    // Set the returnSize for the caller
    *returnSize = numsSize;

    // Iterate through the input array and apply the multiplication
    for (int i = 0; i < numsSize; i++) {
        // First, take nums[i] modulo MOD to handle cases where nums[i] > MOD.
        // Then, cast to long long before multiplying to prevent overflow
        // before the final modulo operation.
        long long current_num_mod = (long long)nums[i] % MOD;
        // If nums[i] can be negative, ensure current_num_mod is non-negative:
        // if (current_num_mod < 0) current_num_mod += MOD;
        // Assuming nums[i] are non-negative as is common in such problems.

        result[i] = (int)((current_num_mod * total_multiplier) % MOD);
    }

    return result;
}
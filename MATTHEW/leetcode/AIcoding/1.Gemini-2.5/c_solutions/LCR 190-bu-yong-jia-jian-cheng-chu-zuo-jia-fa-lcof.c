#include <stdlib.h>

int maximumXORSum(int* nums, int numsSize) {
    // A basis array to store linearly independent numbers.
    // Since nums[i] <= 10^6, numbers fit within 20 bits (2^19 < 10^6 < 2^20).
    // We use 30 for safety and to cover standard integer sizes (up to 2^30-1).
    int basis[30] = {0}; 

    // Construct the basis
    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        // Iterate from the most significant bit (MSB) down to the least significant bit (LSB).
        // For numbers up to 10^6, bits from 19 down to 0 are relevant.
        for (int j = 29; j >= 0; j--) {
            // If the j-th bit of 'num' is not set, it cannot be used to eliminate basis[j]
            // or to be placed at basis[j].
            if (!((num >> j) & 1)) {
                continue;
            }

            // If the j-th position in our basis is empty, place 'num' here.
            // 'num' is now part of the basis and linearly independent.
            if (basis[j] == 0) {
                basis[j] = num;
                break; // Move to the next number in 'nums'
            }

            // If basis[j] is not empty, XOR 'num' with basis[j].
            // This operation eliminates the j-th bit of 'num', effectively reducing 'num'
            // to a smaller value (or 0) that is still linearly independent of basis elements
            // for bits higher than j.
            num ^= basis[j];
        }
    }

    // After constructing the basis, find the maximum XOR sum achievable.
    int max_xor = 0;
    // Iterate from MSB down to LSB.
    // For each bit position, try to set that bit in 'max_xor' if it increases the value.
    for (int j = 29; j >= 0; j--) {
        // If XORing 'max_xor' with basis[j] results in a larger value,
        // it means we can set a higher bit or maintain higher bits while setting a current bit.
        // This greedy approach works because XORing with a basis element only affects
        // bits at or below its most significant bit.
        if ((max_xor ^ basis[j]) > max_xor) {
            max_xor ^= basis[j];
        }
    }

    return max_xor;
}
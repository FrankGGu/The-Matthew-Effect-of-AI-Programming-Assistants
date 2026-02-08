#include <stdbool.h> // Required for 'bool' type
#include <stdint.h>  // Required for 'int64_t' if using explicit fixed-width types, but 'long long' is standard C99.

#define MOD 1000000007

long long maximumXorProduct(long long a, long long b, int n) {
    long long x = 0;

    // Initialize current_a_val and current_b_val with bits higher than n-1.
    // These bits are not affected by x, as x only has n bits (from 0 to n-1).
    // So, (a^x)_high_bits = a_high_bits, and (b^x)_high_bits = b_high_bits.
    // The expression `(1LL << n) - 1` creates a mask with `n` set bits (0 to n-1).
    // `~((1LL << n) - 1)` creates a mask with all bits from `n` onwards set.
    long long current_a_val = a & (~((1LL << n) - 1));
    long long current_b_val = b & (~((1LL << n) - 1));

    // Iterate from the most significant bit (n-1) down to 0.
    for (int i = n - 1; i >= 0; --i) {
        long long bit_mask = 1LL << i;
        bool a_has_bit = (a & bit_mask) != 0;
        bool b_has_bit = (b & bit_mask) != 0;

        if (a_has_bit == b_has_bit) {
            // If a_i == b_i, we want (a^x)_i and (b^x)_i to be 1 to maximize the numbers.
            // This means x_i should be 1 if a_i=0, and x_i should be 0 if a_i=1.
            // In other words, x_i = 1 - a_i.
            if (!a_has_bit) { // a_i = 0, b_i = 0
                x |= bit_mask; // Set x_i to 1
            }
            // Add 1LL << i to both current_a_val and current_b_val, as their i-th bit will be 1.
            current_a_val |= bit_mask;
            current_b_val |= bit_mask;
        } else { // a_i != b_i
            // Here, (a^x)_i and (b^x)_i will always be different, regardless of x_i.
            // One will be 1, the other 0.
            // To maximize the product, we want to keep current_a_val and current_b_val as close as possible
            // while making them as large as possible.
            if (current_a_val < current_b_val) {
                // current_a_val is smaller, try to make (a^x)_i = 1 and (b^x)_i = 0.
                // This means x_i should be chosen such that a_i ^ x_i = 1.
                // If a_i=0, b_i=1: x_i must be 1 (0^1=1, 1^1=0).
                // If a_i=1, b_i=0: x_i must be 0 (1^0=1, 0^0=0).
                if (!a_has_bit) { // a_i = 0, b_i = 1
                    x |= bit_mask; // Set x_i to 1
                }
                current_a_val |= bit_mask; // Add 1LL << i to current_a_val
            } else { // current_a_val >= current_b_val
                // current_b_val is smaller or equal, try to make (a^x)_i = 0 and (b^x)_i = 1.
                // This means x_i should be chosen such that b_i ^ x_i = 1.
                // If a_i=0, b_i=1: x_i must be 0 (0^0=0, 1^0=1).
                // If a_i=1, b_i=0: x_i must be 1 (1^1=0, 0^1=1).
                if (a_has_bit) { // a_i = 1, b_i = 0
                    x |= bit_mask; // Set x_i to 1
                }
                current_b_val |= bit_mask; // Add 1LL << i to current_b_val
            }
        }
    }

    // current_a_val and current_b_val now hold the final (a^x) and (b^x) values.
    // Calculate the product modulo MOD.
    long long result = (current_a_val % MOD * current_b_val % MOD) % MOD;
    return result;
}
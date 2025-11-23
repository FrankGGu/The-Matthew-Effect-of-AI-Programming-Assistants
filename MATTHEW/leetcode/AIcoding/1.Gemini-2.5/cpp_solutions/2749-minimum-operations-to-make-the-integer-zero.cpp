#include <numeric> // Required for __builtin_popcountll on some compilers, though often implicitly available.

class Solution {
public:
    int minimumOperations(int n, int k) {
        // Iterate through possible number of operations 'x'.
        // The maximum number of set bits for a 'long long' is 64.
        // This means 'x' must be at least __builtin_popcountll(remaining).
        // If 'x' is greater than 64, the condition __builtin_popcountll(remaining) <= x
        // is almost always met, as __builtin_popcountll(remaining) will be at most 64.
        // Therefore, iterating 'x' up to a small constant like 65 (or slightly more) is sufficient,
        // as the minimum 'x' will be found within this range if a solution exists.
        for (int x = 1; x <= 65; ++x) { 
            long long remaining = (long long)n - (long long)x * k;

            // Condition 1: The 'remaining' value must be at least 'x'.
            // This is because each of the 'x' operations effectively subtracts a power of 2 (which is at least 2^0 = 1).
            // So, the sum of 'x' powers of 2 must be at least 'x'.
            // If 'remaining' is less than 'x', it cannot be represented as a sum of 'x' powers of 2.
            // This check also implicitly handles cases where 'remaining' becomes negative, as `x >= 1`.
            if (remaining < x) {
                // If 'k' is non-negative, 'remaining' decreases as 'x' increases.
                // If 'remaining < x' is true for the current 'x', it will also be true (or more pronounced) for larger 'x'.
                // Thus, we can break early as no larger 'x' will satisfy 'remaining >= x'.
                if (k >= 0) {
                    break;
                }
                // If 'k' is negative, 'remaining' increases as 'x' increases.
                // So, if 'remaining < x' is true for the current 'x', it might become false for a larger 'x'.
                // We must continue to check larger 'x' values.
                else {
                    continue;
                }
            }

            // Condition 2: The number of set bits in 'remaining' must be less than or equal to 'x'.
            // __builtin_popcountll(value) counts the number of '1's in the binary representation of 'value'.
            // This is the minimum number of powers of 2 (distinct or non-distinct) required to sum up to 'remaining'.
            // If __builtin_popcountll(remaining) > x, it means we need more than 'x' terms to form 'remaining',
            // which is impossible if we only have 'x' operations.
            // If __builtin_popcountll(remaining) <= x, it is always possible to represent 'remaining' as a sum of 'x' powers of 2.
            // We can take the 'popcount' terms and repeatedly replace any 2^j (where j > 0) with two 2^(j-1) terms
            // until we have exactly 'x' terms. This process increases the number of terms by one while maintaining the sum.
            if (__builtin_popcountll(remaining) <= x) {
                return x; // Found the minimum number of operations
            }
        }

        return -1; // No solution found within the checked range of 'x'
    }
};
#include <vector>
#include <numeric> // Required for std::gcd

class Solution {
public:
    bool isGoodArray(std::vector<int>& nums) {
        // According to Bezout's identity, for a set of integers {a_1, a_2, ..., a_n},
        // the smallest positive integer that can be expressed as a linear combination
        // sum(x_i * a_i) where x_i are *integer* coefficients, is equal to gcd(a_1, a_2, ..., a_n).
        //
        // If the problem implies that integer coefficients are allowed (despite the "non-negative" wording,
        // which can be a common source of confusion or a slight misstatement in competitive programming problems
        // of this type), then the array is "good" if and only if the greatest common divisor (GCD)
        // of all its elements is 1. If the GCD is 1, then 1 can be expressed as a linear combination.
        // If the GCD is greater than 1, then any linear combination (with integer or non-negative integer coefficients)
        // must be a multiple of the GCD, and thus cannot be 1.
        //
        // This interpretation is common for "good array" problems involving GCD and linear combinations,
        // especially for "Medium" difficulty problems where a simple check for '1' would be too trivial.

        int current_gcd = nums[0];

        // Iterate through the array and compute the GCD of all elements.
        // If the GCD becomes 1 at any point, it will remain 1, and we can return true early.
        for (size_t i = 1; i < nums.size(); ++i) {
            current_gcd = std::gcd(current_gcd, nums[i]);
            if (current_gcd == 1) {
                return true;
            }
        }

        // After checking all elements, if current_gcd is 1, it means the GCD of the entire array is 1.
        return current_gcd == 1;
    }
};
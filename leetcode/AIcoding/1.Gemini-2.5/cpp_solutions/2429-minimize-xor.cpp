#include <bit> // Required for std::popcount in C++20, or __builtin_popcount for GCC extensions

class Solution {
public:
    int minimizeXor(int num1, int num2) {
        // Get the target number of set bits for our result 'x'
        // Using __builtin_popcount for broader compatibility on LeetCode platforms
        int targetSetBits = __builtin_popcount(num2); 
        int ans = 0;

        // Phase 1: Prioritize setting bits in 'ans' that are also set in 'num1'.
        // This minimizes the XOR value by making common bits 0.
        // Iterate from most significant bit (MSB) down to least significant bit (LSB).
        for (int i = 30; i >= 0 && targetSetBits > 0; --i) {
            if ((num1 >> i) & 1) { // If the i-th bit of num1 is set
                ans |= (1 << i);   // Set the i-th bit in ans
                targetSetBits--;   // Decrement the count of bits we still need to set
            }
        }

        // Phase 2: If 'targetSetBits' is still positive, we need to set more bits in 'ans'.
        // Choose bits that are NOT set in 'num1' and are not already set in 'ans'.
        // Iterate from LSB up to MSB to minimize the overall value of 'ans'
        // (and thus 'num1 XOR ans' by adding smaller powers of 2).
        for (int i = 0; i <= 30 && targetSetBits > 0; ++i) {
            // If the i-th bit of num1 is NOT set AND the i-th bit of ans is NOT already set
            if (!((num1 >> i) & 1) && !((ans >> i) & 1)) {
                ans |= (1 << i);   // Set the i-th bit in ans
                targetSetBits--;   // Decrement the count of bits we still need to set
            }
        }

        return ans;
    }
};
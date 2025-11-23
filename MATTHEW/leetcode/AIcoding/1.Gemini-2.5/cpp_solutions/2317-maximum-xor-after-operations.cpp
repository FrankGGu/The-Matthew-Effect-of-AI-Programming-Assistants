#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int maximumXORSum(std::vector<int>& nums) {
        int initial_OR = 0;
        int and_all = -1; // Initialize with all bits set (e.g., ~0 or 0xFFFFFFFF)
        int n = nums.size();

        if (n == 0) {
            return 0;
        }

        for (int x : nums) {
            initial_OR |= x;
            and_all &= x;
        }

        int max_xor_sum = 0;
        // Iterate through each bit position from 0 up to 30 (since nums[i] <= 10^9, which is less than 2^30)
        for (int k = 0; k < 31; ++k) {
            int k_th_bit_of_OR = (initial_OR >> k) & 1;
            int k_th_bit_of_AND = (and_all >> k) & 1;

            if (k_th_bit_of_OR == 1) {
                // If the k-th bit is 1 in initial_OR, it means at least one number has this bit set.
                // We want to make the k-th bit of the final XOR sum 1 if possible.

                if (k_th_bit_of_AND == 0) {
                    // This means not all numbers have the k-th bit set initially.
                    // So, there exists at least one number `nums[y]` with k-th bit 0.
                    // We can use `nums[y]` to turn off the k-th bit in other numbers `nums[x]`
                    // (by `nums[x] = nums[x] & nums[y]`).
                    // We can arrange it such that exactly one element has its k-th bit set,
                    // and all others have it 0. This makes the k-th bit of the final XOR sum 1.
                    max_xor_sum |= (1 << k);
                } else { // k_th_bit_of_AND == 1
                    // This means ALL numbers initially have the k-th bit set to 1.
                    // The bitwise AND operation `nums[i] = nums[i] & nums[j]` can only turn 1-bits to 0-bits.
                    // If all numbers have their k-th bit as 1, no operation can change any k-th bit to 0.
                    // So, all numbers in the final array `nums'` will have their k-th bit as 1.
                    // The k-th bit of the final XOR sum will be 1 if n is odd (odd number of 1s XORed together),
                    // and 0 if n is even (even number of 1s XORed together).
                    if (n % 2 == 1) {
                        max_xor_sum |= (1 << k);
                    }
                    // If n is even, max_xor_sum's k-th bit remains 0.
                }
            } else {
                // If the k-th bit is 0 in initial_OR, it means all numbers initially have this bit as 0.
                // The bitwise AND operation cannot turn a 0-bit into a 1-bit.
                // So, the k-th bit of all numbers in `nums'` will remain 0.
                // Thus, the k-th bit of the final XOR sum must also be 0.
            }
        }

        return max_xor_sum;
    }
};
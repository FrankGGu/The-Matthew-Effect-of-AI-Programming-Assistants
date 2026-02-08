#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    std::vector<int> getMaximumXor(std::vector<int>& nums, int maximumBit) {
        int n = nums.size();
        std::vector<int> result;

        int current_xor_sum = 0;
        // Calculate the mask for the lower 'maximumBit' bits.
        // This mask has 'maximumBit' number of 1s from the LSB.
        // For example, if maximumBit = 3, max_val_for_k_bits = (1 << 3) - 1 = 7 (binary 111).
        int max_val_for_k_bits = (1 << maximumBit) - 1;

        for (int i = 0; i < n; ++i) {
            current_xor_sum ^= nums[i];

            // To maximize (current_xor_sum XOR k) where 0 <= k < 2^maximumBit:
            // We want k to have bits that are the complement of current_xor_sum's bits
            // for the positions from 0 to maximumBit - 1.
            // For positions >= maximumBit, k must have 0s.
            // This can be achieved by computing the bitwise NOT of current_xor_sum
            // and then masking it with max_val_for_k_bits to keep only the lower 'maximumBit' bits.
            int k = (~current_xor_sum) & max_val_for_k_bits;

            result.push_back(k);
        }

        // The problem asks for the maximum XOR value for queries where elements are
        // removed from the end of the array.
        // Query 0: nums[0...n-1]
        // Query 1: nums[0...n-2]
        // ...
        // Query n-1: nums[0...0]
        // Our 'result' vector currently stores k values for prefixes:
        // result[0] for nums[0...0]
        // result[1] for nums[0...1]
        // ...
        // result[n-1] for nums[0...n-1]
        // To match the required query order, we need to reverse the result vector.
        std::reverse(result.begin(), result.end());

        return result;
    }
};
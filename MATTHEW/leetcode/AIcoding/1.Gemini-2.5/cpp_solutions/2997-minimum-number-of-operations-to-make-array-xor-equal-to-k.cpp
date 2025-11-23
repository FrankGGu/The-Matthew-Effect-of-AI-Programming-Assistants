class Solution {
public:
    int minOperations(std::vector<int>& nums, int k) {
        int current_xor_sum = 0;
        for (int num : nums) {
            current_xor_sum ^= num;
        }

        int diff = current_xor_sum ^ k;

        // Count the number of set bits (1s) in 'diff'.
        // This count represents the minimum number of operations needed
        // to change the current_xor_sum to k.
        // __builtin_popcount is a GCC/Clang extension for counting set bits.
        return __builtin_popcount(diff);
    }
};
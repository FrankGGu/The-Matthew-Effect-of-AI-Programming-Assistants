#include <vector>
#include <numeric>

class Solution {
public:
    int minOperations(std::vector<int>& nums, int k) {
        int current_xor_sum = 0;
        for (int num : nums) {
            current_xor_sum ^= num;
        }

        int diff = current_xor_sum ^ k;

        return __builtin_popcount(diff);
    }
};
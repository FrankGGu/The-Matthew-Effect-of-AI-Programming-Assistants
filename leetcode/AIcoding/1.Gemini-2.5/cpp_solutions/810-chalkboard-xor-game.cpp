#include <vector>
#include <numeric>

class Solution {
public:
    bool chalkboardXORGame(std::vector<int>& nums) {
        int xor_sum = 0;
        for (int num : nums) {
            xor_sum ^= num;
        }

        if (xor_sum == 0) {
            return false; 
        } else {
            // If the XOR sum is not 0, Alice wins if there's an odd number of elements.
            // Otherwise, Bob wins (Alice loses).
            return nums.size() % 2 == 1;
        }
    }
};
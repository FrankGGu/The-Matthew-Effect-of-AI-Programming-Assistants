#include <vector>

class Solution {
public:
    int minOperations(std::vector<int>& nums) {
        int operations = 0;
        int current_flip_parity = 0;

        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] == current_flip_parity) {
                operations++;
                current_flip_parity = 1 - current_flip_parity;
            }
        }

        return operations;
    }
};
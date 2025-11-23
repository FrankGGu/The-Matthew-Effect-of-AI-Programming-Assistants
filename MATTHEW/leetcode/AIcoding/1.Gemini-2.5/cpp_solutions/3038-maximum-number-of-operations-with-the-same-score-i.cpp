#include <vector>

class Solution {
public:
    int maxOperations(std::vector<int>& nums) {
        if (nums.size() < 2) {
            return 0;
        }

        int target_score = nums[0] + nums[1];
        int operations_count = 1;

        for (int i = 2; i + 1 < nums.size(); i += 2) {
            if (nums[i] + nums[i+1] == target_score) {
                operations_count++;
            } else {
                break;
            }
        }

        return operations_count;
    }
};
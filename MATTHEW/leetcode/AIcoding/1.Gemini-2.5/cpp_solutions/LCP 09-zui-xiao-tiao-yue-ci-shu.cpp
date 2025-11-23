#include <vector>
#include <algorithm>

class Solution {
public:
    int jump(std::vector<int>& nums) {
        int n = nums.size();
        if (n <= 1) {
            return 0;
        }

        int jumps = 0;
        int current_jump_end = 0;
        int farthest_reach = 0;

        for (int i = 0; i < n - 1; ++i) {
            farthest_reach = std::max(farthest_reach, i + nums[i]);

            if (i == current_jump_end) {
                jumps++;
                current_jump_end = farthest_reach;
                if (current_jump_end >= n - 1) {
                    break; 
                }
            }
        }

        return jumps;
    }
};
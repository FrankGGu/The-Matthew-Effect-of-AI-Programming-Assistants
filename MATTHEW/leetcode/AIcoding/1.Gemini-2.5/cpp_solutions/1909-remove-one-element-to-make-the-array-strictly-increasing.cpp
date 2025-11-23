#include <vector>
#include <numeric>

class Solution {
public:
    bool canBeIncreasing(std::vector<int>& nums) {
        int n = nums.size();
        int p = -1;

        for (int i = 1; i < n; ++i) {
            if (nums[i] <= nums[i - 1]) {
                if (p != -1) {
                    return false;
                }
                p = i;
            }
        }

        if (p == -1) {
            return true;
        }

        bool remove_prev_possible = (p == 1 || nums[p] > nums[p - 2]);
        bool remove_curr_possible = (p == n - 1 || nums[p + 1] > nums[p - 1]);

        return remove_prev_possible || remove_curr_possible;
    }
};
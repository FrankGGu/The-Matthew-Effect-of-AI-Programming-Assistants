#include <vector>
#include <algorithm>

class Solution {
public:
    bool isGood(std::vector<int>& nums) {
        int n = nums.size();
        if (n <= 1) {
            return false;
        }

        int base_n = n - 1;

        std::sort(nums.begin(), nums.end());

        for (int i = 0; i < base_n; ++i) {
            if (nums[i] != i + 1) {
                return false;
            }
        }

        if (nums[base_n] != base_n) {
            return false;
        }

        return true;
    }
};
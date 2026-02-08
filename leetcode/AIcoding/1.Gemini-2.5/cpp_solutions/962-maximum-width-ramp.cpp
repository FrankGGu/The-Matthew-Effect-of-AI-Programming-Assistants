#include <vector>
#include <algorithm>

class Solution {
public:
    int maxWidthRamp(std::vector<int>& nums) {
        int n = nums.size();
        if (n < 2) {
            return 0;
        }

        std::vector<int> left_candidates; 

        for (int i = 0; i < n; ++i) {
            if (left_candidates.empty() || nums[i] < nums[left_candidates.back()]) {
                left_candidates.push_back(i);
            }
        }

        int max_width = 0;
        for (int j = n - 1; j >= 0; --j) {
            while (!left_candidates.empty() && nums[left_candidates.back()] <= nums[j]) {
                max_width = std::max(max_width, j - left_candidates.back());
                left_candidates.pop_back();
            }
        }

        return max_width;
    }
};
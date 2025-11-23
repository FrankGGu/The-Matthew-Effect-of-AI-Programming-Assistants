#include <vector>
#include <algorithm>

class Solution {
public:
    int minimumDeletions(std::vector<int>& nums) {
        int n = nums.size();
        if (n == 1) {
            return 1;
        }

        int min_val = nums[0];
        int max_val = nums[0];
        int min_idx = 0;
        int max_idx = 0;

        for (int i = 1; i < n; ++i) {
            if (nums[i] < min_val) {
                min_val = nums[i];
                min_idx = i;
            }
            if (nums[i] > max_val) {
                max_val = nums[i];
                max_idx = i;
            }
        }

        int deletions_from_front = std::max(min_idx, max_idx) + 1;
        int deletions_from_back = n - std::min(min_idx, max_idx);
        int deletions_from_both = (std::min(min_idx, max_idx) + 1) + (n - std::max(min_idx, max_idx));

        return std::min({deletions_from_front, deletions_from_back, deletions_from_both});
    }
};
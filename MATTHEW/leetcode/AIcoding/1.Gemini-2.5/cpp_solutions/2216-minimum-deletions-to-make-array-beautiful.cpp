#include <vector>

class Solution {
public:
    int minDeletion(std::vector<int>& nums) {
        int deletions = 0;
        int n = nums.size();

        for (int i = 0; i < n; ++i) {
            int effective_index = i - deletions;
            if (effective_index % 2 == 0) {
                if (i + 1 < n && nums[i] == nums[i + 1]) {
                    deletions++;
                }
            }
        }

        if ((n - deletions) % 2 != 0) {
            deletions++;
        }

        return deletions;
    }
};
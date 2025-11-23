#include <vector>
#include <algorithm>

class Solution {
public:
    int partitionDisjoint(std::vector<int>& nums) {
        int n = nums.size();
        std::vector<int> maxLeft(n);
        std::vector<int> minRight(n);

        maxLeft[0] = nums[0];
        for (int i = 1; i < n; ++i) {
            maxLeft[i] = std::max(maxLeft[i - 1], nums[i]);
        }

        minRight[n - 1] = nums[n - 1];
        for (int i = n - 2; i >= 0; --i) {
            minRight[i] = std::min(minRight[i + 1], nums[i]);
        }

        for (int i = 0; i < n - 1; ++i) {
            if (maxLeft[i] <= minRight[i + 1]) {
                return i + 1;
            }
        }

        return -1; // Should not be reached based on problem constraints
    }
};
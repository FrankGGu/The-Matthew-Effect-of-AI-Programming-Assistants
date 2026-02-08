#include <vector>
#include <cmath>

class Solution {
public:
    std::vector<int> findIndices(std::vector<int>& nums, int indexDifference, int valueDifference) {
        int n = nums.size();
        int min_idx = 0;
        int max_idx = 0;

        for (int j = indexDifference; j < n; ++j) {
            int i = j - indexDifference;

            if (nums[i] < nums[min_idx]) {
                min_idx = i;
            }
            if (nums[i] > nums[max_idx]) {
                max_idx = i;
            }

            if ((long long)nums[j] - nums[min_idx] >= valueDifference) {
                return {min_idx, j};
            }
            if ((long long)nums[max_idx] - nums[j] >= valueDifference) {
                return {max_idx, j};
            }
        }

        return {-1, -1};
    }
};
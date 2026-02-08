#include <vector>
#include <numeric>

class Solution {
public:
    std::vector<int> goodIndices(std::vector<int>& nums, int k) {
        int n = nums.size();
        std::vector<int> result;

        std::vector<int> left(n);
        left[0] = 1;
        for (int j = 1; j < n; ++j) {
            if (nums[j-1] >= nums[j]) {
                left[j] = left[j-1] + 1;
            } else {
                left[j] = 1;
            }
        }

        std::vector<int> right(n);
        right[n-1] = 1;
        for (int j = n - 2; j >= 0; --j) {
            if (nums[j] <= nums[j+1]) {
                right[j] = right[j+1] + 1;
            } else {
                right[j] = 1;
            }
        }

        for (int i = k; i < n - k; ++i) {
            if (left[i-1] >= k && right[i+1] >= k) {
                result.push_back(i);
            }
        }

        return result;
    }
};
#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> maxLength(const std::vector<int>& nums, const std::vector<int>& queries) {
        std::vector<int> result;
        std::vector<int> prefixSum(nums.size() + 1, 0);

        std::sort(nums.begin(), nums.end());
        for (int i = 0; i < nums.size(); ++i) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        for (const auto& query : queries) {
            int left = 0, right = nums.size();
            while (left < right) {
                int mid = left + (right - left) / 2;
                if (prefixSum[mid + 1] <= query) {
                    left = mid + 1;
                } else {
                    right = mid;
                }
            }
            result.push_back(left);
        }

        return result;
    }
};
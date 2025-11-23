#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    std::vector<int> answerQueries(std::vector<int>& nums, std::vector<int>& queries) {
        std::sort(nums.begin(), nums.end());

        for (size_t i = 1; i < nums.size(); ++i) {
            nums[i] += nums[i - 1];
        }

        std::vector<int> ans;
        ans.reserve(queries.size());

        for (int query : queries) {
            auto it = std::upper_bound(nums.begin(), nums.end(), query);
            ans.push_back(std::distance(nums.begin(), it));
        }

        return ans;
    }
};
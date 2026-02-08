#include <vector>
#include <algorithm>

class Solution {
public:
    void backtrack(std::vector<int>& nums, std::vector<int>& subset, int start, std::vector<std::vector<int>>& result) {
        result.push_back(subset);
        for (int i = start; i < nums.size(); i++) {
            if (i > start && nums[i] == nums[i - 1]) continue;
            subset.push_back(nums[i]);
            backtrack(nums, subset, i + 1, result);
            subset.pop_back();
        }
    }

    std::vector<std::vector<int>> subsetsWithDup(std::vector<int>& nums) {
        std::vector<std::vector<int>> result;
        std::vector<int> subset;
        std::sort(nums.begin(), nums.end());
        backtrack(nums, subset, 0, result);
        return result;
    }
};
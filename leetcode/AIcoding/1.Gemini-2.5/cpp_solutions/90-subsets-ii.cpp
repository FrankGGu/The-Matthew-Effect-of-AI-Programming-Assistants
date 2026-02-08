#include <vector>
#include <algorithm>
#include <set>

class Solution {
public:
    void backtrack(std::vector<int>& nums, int start, std::vector<int>& currentSubset, std::vector<std::vector<int>>& result) {
        result.push_back(currentSubset);

        for (int i = start; i < nums.size(); ++i) {
            if (i > start && nums[i] == nums[i-1]) {
                continue;
            }
            currentSubset.push_back(nums[i]);
            backtrack(nums, i + 1, currentSubset, result);
            currentSubset.pop_back();
        }
    }

    std::vector<std::vector<int>> subsetsWithDup(std::vector<int>& nums) {
        std::sort(nums.begin(), nums.end());
        std::vector<std::vector<int>> result;
        std::vector<int> currentSubset;
        backtrack(nums, 0, currentSubset, result);
        return result;
    }
};
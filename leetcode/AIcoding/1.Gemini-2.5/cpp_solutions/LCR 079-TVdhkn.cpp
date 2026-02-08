#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> subsetsWithDup(std::vector<int>& nums) {
        std::vector<std::vector<int>> result;
        std::vector<int> currentSubset;
        std::sort(nums.begin(), nums.end());

        backtrack(0, nums, currentSubset, result);

        return result;
    }

private:
    void backtrack(int start_index, const std::vector<int>& nums,
                   std::vector<int>& currentSubset,
                   std::vector<std::vector<int>>& result) {

        result.push_back(currentSubset);

        for (int i = start_index; i < nums.size(); ++i) {
            if (i > start_index && nums[i] == nums[i-1]) {
                continue;
            }

            currentSubset.push_back(nums[i]);
            backtrack(i + 1, nums, currentSubset, result);
            currentSubset.pop_back();
        }
    }
};
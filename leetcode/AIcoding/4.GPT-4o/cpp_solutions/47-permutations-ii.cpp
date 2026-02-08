#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> permuteUnique(std::vector<int>& nums) {
        std::vector<std::vector<int>> result;
        std::sort(nums.begin(), nums.end());
        backtrack(nums, result, 0);
        return result;
    }

    void backtrack(std::vector<int>& nums, std::vector<std::vector<int>>& result, int start) {
        if (start >= nums.size()) {
            result.push_back(nums);
            return;
        }
        for (int i = start; i < nums.size(); i++) {
            if (i > start && nums[i] == nums[start]) continue; // skip duplicates
            std::swap(nums[start], nums[i]);
            backtrack(nums, result, start + 1);
            std::swap(nums[start], nums[i]); // backtrack
        }
    }
};
#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> permute(std::vector<int>& nums) {
        std::vector<std::vector<int>> result;
        backtrack(0, nums, result);
        return result;
    }

private:
    void backtrack(int index, std::vector<int>& nums, std::vector<std::vector<int>>& result) {
        if (index == nums.size()) {
            result.push_back(nums);
            return;
        }
        for (int i = index; i < nums.size(); ++i) {
            std::swap(nums[index], nums[i]);
            backtrack(index + 1, nums, result);
            std::swap(nums[index], nums[i]);
        }
    }
};
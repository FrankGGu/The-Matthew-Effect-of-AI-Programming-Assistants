#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> permuteUnique(std::vector<int>& nums) {
        std::vector<std::vector<int>> result;
        std::sort(nums.begin(), nums.end());
        backtrack(result, nums, {}, std::vector<bool>(nums.size(), false));
        return result;
    }

private:
    void backtrack(std::vector<std::vector<int>>& result, std::vector<int>& nums, std::vector<int> current, std::vector<bool>& used) {
        if (current.size() == nums.size()) {
            result.push_back(current);
            return;
        }
        for (int i = 0; i < nums.size(); ++i) {
            if (used[i] || (i > 0 && nums[i] == nums[i - 1] && !used[i - 1])) continue;
            used[i] = true;
            current.push_back(nums[i]);
            backtrack(result, nums, current, used);
            used[i] = false;
            current.pop_back();
        }
    }
};
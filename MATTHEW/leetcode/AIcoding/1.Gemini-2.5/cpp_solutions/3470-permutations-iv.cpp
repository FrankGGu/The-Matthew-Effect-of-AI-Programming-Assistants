#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> permuteUnique(std::vector<int>& nums) {
        std::vector<std::vector<int>> result;
        std::vector<int> path;
        std::vector<bool> used(nums.size(), false);
        std::sort(nums.begin(), nums.end());
        backtrack(nums, path, used, result);
        return result;
    }

private:
    void backtrack(const std::vector<int>& nums, std::vector<int>& path, std::vector<bool>& used, std::vector<std::vector<int>>& result) {
        if (path.size() == nums.size()) {
            result.push_back(path);
            return;
        }

        for (int i = 0; i < nums.size(); ++i) {
            if (used[i] || (i > 0 && nums[i] == nums[i - 1] && !used[i - 1])) {
                continue;
            }

            used[i] = true;
            path.push_back(nums[i]);
            backtrack(nums, path, used, result);
            path.pop_back();
            used[i] = false;
        }
    }
};
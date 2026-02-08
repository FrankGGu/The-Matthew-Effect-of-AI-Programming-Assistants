#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> permuteUnique(std::vector<int>& nums) {
        std::vector<std::vector<int>> result;
        std::vector<int> current_permutation;
        std::vector<bool> used(nums.size(), false);

        std::sort(nums.begin(), nums.end());

        backtrack(nums, result, current_permutation, used);

        return result;
    }

private:
    void backtrack(const std::vector<int>& nums,
                   std::vector<std::vector<int>>& result,
                   std::vector<int>& current_permutation,
                   std::vector<bool>& used) {
        if (current_permutation.size() == nums.size()) {
            result.push_back(current_permutation);
            return;
        }

        for (int i = 0; i < nums.size(); ++i) {
            if (used[i]) {
                continue;
            }

            if (i > 0 && nums[i] == nums[i-1] && !used[i-1]) {
                continue;
            }

            current_permutation.push_back(nums[i]);
            used[i] = true;
            backtrack(nums, result, current_permutation, used);
            used[i] = false;
            current_permutation.pop_back();
        }
    }
};
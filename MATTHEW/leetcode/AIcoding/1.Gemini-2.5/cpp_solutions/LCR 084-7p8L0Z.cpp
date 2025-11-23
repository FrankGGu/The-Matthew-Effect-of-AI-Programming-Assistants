#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    std::vector<std::vector<int>> permuteUnique(std::vector<int>& nums) {
        std::vector<std::vector<int>> result;
        std::vector<int> current_permutation;
        std::vector<bool> used(nums.size(), false);

        std::sort(nums.begin(), nums.end());

        backtrack(nums, used, current_permutation, result);

        return result;
    }

private:
    void backtrack(const std::vector<int>& nums, std::vector<bool>& used,
                   std::vector<int>& current_permutation,
                   std::vector<std::vector<int>>& result) {
        if (current_permutation.size() == nums.size()) {
            result.push_back(current_permutation);
            return;
        }

        for (int i = 0; i < nums.size(); ++i) {
            if (used[i]) {
                continue;
            }

            // Skip duplicates: if the current number is the same as the previous one,
            // and the previous one was not used (meaning it was available but skipped
            // in this level of recursion), then choosing the current number would
            // lead to a duplicate permutation.
            if (i > 0 && nums[i] == nums[i-1] && !used[i-1]) {
                continue;
            }

            used[i] = true;
            current_permutation.push_back(nums[i]);
            backtrack(nums, used, current_permutation, result);
            current_permutation.pop_back();
            used[i] = false;
        }
    }
};
#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    std::vector<std::vector<int>> permuteUnique(std::vector<int>& nums) {
        std::vector<std::vector<int>> result;
        std::vector<int> current_permutation;
        std::vector<bool> visited(nums.size(), false);

        std::sort(nums.begin(), nums.end());

        backtrack(nums, current_permutation, visited, result);

        return result;
    }

private:
    void backtrack(std::vector<int>& nums,
                   std::vector<int>& current_permutation,
                   std::vector<bool>& visited,
                   std::vector<std::vector<int>>& result) {
        if (current_permutation.size() == nums.size()) {
            result.push_back(current_permutation);
            return;
        }

        for (int i = 0; i < nums.size(); ++i) {
            if (visited[i]) {
                continue;
            }

            // Skip duplicates: if the current number is the same as the previous number,
            // and the previous number has not been visited (meaning it was skipped
            // in this level of recursion), then skip the current number to avoid
            // duplicate permutations.
            if (i > 0 && nums[i] == nums[i-1] && !visited[i-1]) {
                continue;
            }

            visited[i] = true;
            current_permutation.push_back(nums[i]);
            backtrack(nums, current_permutation, visited, result);
            current_permutation.pop_back();
            visited[i] = false;
        }
    }
};
#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> subsets(std::vector<int>& nums) {
        std::vector<std::vector<int>> result;
        std::vector<int> current_subset;

        backtrack(0, nums, current_subset, result);

        return result;
    }

private:
    void backtrack(int start_index, const std::vector<int>& nums, 
                   std::vector<int>& current_subset, 
                   std::vector<std::vector<int>>& result) {

        result.push_back(current_subset);

        for (int i = start_index; i < nums.size(); ++i) {
            current_subset.push_back(nums[i]);
            backtrack(i + 1, nums, current_subset, result);
            current_subset.pop_back(); 
        }
    }
};
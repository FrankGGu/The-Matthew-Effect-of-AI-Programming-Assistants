class Solution {
public:
    std::vector<std::vector<int>> permute(std::vector<int>& nums) {
        std::vector<std::vector<int>> results;
        std::vector<int> current_permutation;
        std::vector<bool> used(nums.size(), false);

        backtrack(nums, used, current_permutation, results);

        return results;
    }

private:
    void backtrack(const std::vector<int>& nums, std::vector<bool>& used, 
                   std::vector<int>& current_permutation, std::vector<std::vector<int>>& results) {
        if (current_permutation.size() == nums.size()) {
            results.push_back(current_permutation);
            return;
        }

        for (int i = 0; i < nums.size(); ++i) {
            if (!used[i]) {
                current_permutation.push_back(nums[i]);
                used[i] = true;
                backtrack(nums, used, current_permutation, results);
                used[i] = false;
                current_permutation.pop_back();
            }
        }
    }
};
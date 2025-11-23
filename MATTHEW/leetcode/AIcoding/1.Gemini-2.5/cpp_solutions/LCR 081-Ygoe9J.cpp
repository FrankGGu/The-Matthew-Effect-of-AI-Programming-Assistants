#include <vector>

class Solution {
private:
    std::vector<std::vector<int>> result;
    std::vector<int> current_combination;

    void backtrack(const std::vector<int>& candidates, int target, int start_index) {
        if (target == 0) {
            result.push_back(current_combination);
            return;
        }
        if (target < 0) {
            return;
        }

        for (int i = start_index; i < candidates.size(); ++i) {
            current_combination.push_back(candidates[i]);
            backtrack(candidates, target - candidates[i], i);
            current_combination.pop_back();
        }
    }

public:
    std::vector<std::vector<int>> combinationSum(std::vector<int>& candidates, int target) {
        result.clear();
        current_combination.clear();

        backtrack(candidates, target, 0);
        return result;
    }
};
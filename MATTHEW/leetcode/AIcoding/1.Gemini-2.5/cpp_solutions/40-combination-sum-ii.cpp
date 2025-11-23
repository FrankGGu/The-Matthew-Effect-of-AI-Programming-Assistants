#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    std::vector<std::vector<int>> combinationSum2(std::vector<int>& candidates, int target) {
        std::vector<std::vector<int>> result;
        std::vector<int> current_combination;
        std::sort(candidates.begin(), candidates.end());

        backtrack(candidates, target, 0, current_combination, result);

        return result;
    }

private:
    void backtrack(const std::vector<int>& candidates, int target, int start_index, 
                   std::vector<int>& current_combination, 
                   std::vector<std::vector<int>>& result) {
        if (target == 0) {
            result.push_back(current_combination);
            return;
        }

        if (target < 0) {
            return;
        }

        for (int i = start_index; i < candidates.size(); ++i) {
            if (i > start_index && candidates[i] == candidates[i-1]) {
                continue; 
            }

            current_combination.push_back(candidates[i]);
            backtrack(candidates, target - candidates[i], i + 1, current_combination, result);
            current_combination.pop_back();
        }
    }
};
#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    std::vector<std::vector<int>> combinationSum2(std::vector<int>& candidates, int target) {
        std::vector<std::vector<int>> result;
        std::vector<int> currentCombination;
        std::sort(candidates.begin(), candidates.end());

        backtrack(candidates, target, 0, currentCombination, result);

        return result;
    }

private:
    void backtrack(const std::vector<int>& candidates, int target, int start, 
                   std::vector<int>& currentCombination, std::vector<std::vector<int>>& result) {

        if (target == 0) {
            result.push_back(currentCombination);
            return;
        }

        if (target < 0) {
            return;
        }

        for (int i = start; i < candidates.size(); ++i) {
            if (i > start && candidates[i] == candidates[i-1]) {
                continue; 
            }

            if (candidates[i] <= target) {
                currentCombination.push_back(candidates[i]);
                backtrack(candidates, target - candidates[i], i + 1, currentCombination, result);
                currentCombination.pop_back(); 
            }
        }
    }
};
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> combinationSum(vector<int>& candidates, int target) {
        vector<vector<int>> result;
        vector<int> combination;
        sort(candidates.begin(), candidates.end());
        combinationSumHelper(candidates, target, 0, combination, result);
        return result;
    }

private:
    void combinationSumHelper(vector<int>& candidates, int target, int start, vector<int>& combination, vector<vector<int>>& result) {
        if (target == 0) {
            result.push_back(combination);
            return;
        }

        if (target < 0) {
            return;
        }

        for (int i = start; i < candidates.size(); ++i) {
            combination.push_back(candidates[i]);
            combinationSumHelper(candidates, target - candidates[i], i, combination, result);
            combination.pop_back();
        }
    }
};
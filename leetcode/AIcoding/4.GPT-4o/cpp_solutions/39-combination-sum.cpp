class Solution {
public:
    void backtrack(vector<vector<int>>& result, vector<int>& combination, vector<int>& candidates, int target, int start) {
        if (target == 0) {
            result.push_back(combination);
            return;
        }
        for (int i = start; i < candidates.size(); i++) {
            if (candidates[i] > target) continue;
            combination.push_back(candidates[i]);
            backtrack(result, combination, candidates, target - candidates[i], i);
            combination.pop_back();
        }
    }

    vector<vector<int>> combinationSum(vector<int>& candidates, int target) {
        vector<vector<int>> result;
        vector<int> combination;
        backtrack(result, combination, candidates, target, 0);
        return result;
    }
};
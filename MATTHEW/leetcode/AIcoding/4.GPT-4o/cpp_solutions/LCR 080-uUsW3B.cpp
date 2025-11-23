class Solution {
public:
    vector<vector<int>> combine(int n, int k) {
        vector<vector<int>> result;
        vector<int> combination;
        backtrack(result, combination, n, k, 1);
        return result;
    }

    void backtrack(vector<vector<int>>& result, vector<int>& combination, int n, int k, int start) {
        if (combination.size() == k) {
            result.push_back(combination);
            return;
        }

        for (int i = start; i <= n; ++i) {
            combination.push_back(i);
            backtrack(result, combination, n, k, i + 1);
            combination.pop_back();
        }
    }
};
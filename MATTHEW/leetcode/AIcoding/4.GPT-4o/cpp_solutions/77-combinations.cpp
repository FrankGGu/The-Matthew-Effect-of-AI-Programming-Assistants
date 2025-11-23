class Solution {
public:
    void backtrack(int start, int k, vector<int>& comb, vector<vector<int>>& result) {
        if (comb.size() == k) {
            result.push_back(comb);
            return;
        }
        for (int i = start; i <= 9; ++i) {
            comb.push_back(i);
            backtrack(i + 1, k, comb, result);
            comb.pop_back();
        }
    }

    vector<vector<int>> combine(int n, int k) {
        vector<vector<int>> result;
        vector<int> comb;
        backtrack(1, k, comb, result);
        return result;
    }
};
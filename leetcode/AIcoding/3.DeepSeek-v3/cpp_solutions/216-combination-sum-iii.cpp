class Solution {
public:
    vector<vector<int>> combinationSum3(int k, int n) {
        vector<vector<int>> res;
        vector<int> path;
        backtrack(res, path, 1, k, n);
        return res;
    }

    void backtrack(vector<vector<int>>& res, vector<int>& path, int start, int k, int n) {
        if (path.size() == k && n == 0) {
            res.push_back(path);
            return;
        }
        for (int i = start; i <= 9; ++i) {
            if (n - i < 0) break;
            path.push_back(i);
            backtrack(res, path, i + 1, k, n - i);
            path.pop_back();
        }
    }
};
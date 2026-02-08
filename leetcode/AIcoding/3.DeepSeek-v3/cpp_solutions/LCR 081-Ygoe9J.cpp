#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    vector<vector<int>> combinationSum(vector<int>& candidates, int target) {
        vector<vector<int>> res;
        vector<int> path;
        sort(candidates.begin(), candidates.end());
        backtrack(candidates, target, 0, path, res);
        return res;
    }

private:
    void backtrack(vector<int>& candidates, int target, int start, vector<int>& path, vector<vector<int>>& res) {
        if (target == 0) {
            res.push_back(path);
            return;
        }
        for (int i = start; i < candidates.size(); i++) {
            if (candidates[i] > target) break;
            path.push_back(candidates[i]);
            backtrack(candidates, target - candidates[i], i, path, res);
            path.pop_back();
        }
    }
};
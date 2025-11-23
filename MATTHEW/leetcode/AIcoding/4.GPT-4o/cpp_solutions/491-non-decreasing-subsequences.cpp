class Solution {
public:
    void backtrack(vector<int>& nums, vector<int>& path, int start, set<vector<int>>& result) {
        if (path.size() > 1) {
            result.insert(path);
        }
        for (int i = start; i < nums.size(); ++i) {
            if (path.empty() || nums[i] >= path.back()) {
                path.push_back(nums[i]);
                backtrack(nums, path, i + 1, result);
                path.pop_back();
            }
        }
    }

    vector<vector<int>> findSubsequences(vector<int>& nums) {
        set<vector<int>> result;
        vector<int> path;
        backtrack(nums, path, 0, result);
        return vector<vector<int>>(result.begin(), result.end());
    }
};
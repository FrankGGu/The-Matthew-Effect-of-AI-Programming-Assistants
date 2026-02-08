#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<vector<int>> findSubsequences(vector<int>& nums) {
        vector<vector<int>> result;
        vector<int> path;
        dfs(nums, 0, path, result);
        return result;
    }

private:
    void dfs(const vector<int>& nums, int start, vector<int>& path, vector<vector<int>>& result) {
        if (path.size() >= 2) {
            result.push_back(path);
        }
        unordered_set<int> used;
        for (int i = start; i < nums.size(); ++i) {
            if (!path.empty() && nums[i] < path.back()) continue;
            if (used.find(nums[i]) != used.end()) continue;
            used.insert(nums[i]);
            path.push_back(nums[i]);
            dfs(nums, i + 1, path, result);
            path.pop_back();
        }
    }
};
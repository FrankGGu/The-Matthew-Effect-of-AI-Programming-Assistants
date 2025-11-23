#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> allPathsSourceTarget(TreeNode* root) {
        vector<vector<int>> result;
        vector<int> path;
        dfs(root, path, result);
        return result;
    }

private:
    void dfs(TreeNode* node, vector<int>& path, vector<vector<int>>& result) {
        if (!node) return;
        path.push_back(node->val);
        if (!node->left && !node->right) {
            result.push_back(path);
        } else {
            dfs(node->left, path, result);
            dfs(node->right, path, result);
        }
        path.pop_back();
    }
};
#include <iostream>
#include <vector>
#include <TreeNode.h>

using namespace std;

class Solution {
public:
    vector<vector<int>> pathSum(TreeNode* root, int sum) {
        vector<vector<int>> result;
        vector<int> path;
        dfs(root, sum, path, result);
        return result;
    }

private:
    void dfs(TreeNode* node, int target, vector<int>& path, vector<vector<int>>& result) {
        if (!node) return;
        path.push_back(node->val);
        if (!node->left && !node->right && target == node->val) {
            result.push_back(path);
        }
        dfs(node->left, target - node->val, path, result);
        dfs(node->right, target - node->val, path, result);
        path.pop_back();
    }
};
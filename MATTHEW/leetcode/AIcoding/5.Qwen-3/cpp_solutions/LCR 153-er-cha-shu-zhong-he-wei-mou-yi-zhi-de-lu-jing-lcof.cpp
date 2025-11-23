#include <iostream>
#include <vector>
#include <TreeNode.h>

using namespace std;

class Solution {
public:
    vector<vector<int>> pathSum(TreeNode* root, int targetSum) {
        vector<vector<int>> result;
        vector<int> path;
        dfs(root, targetSum, 0, path, result);
        return result;
    }

private:
    void dfs(TreeNode* node, int target, int currentSum, vector<int>& path, vector<vector<int>>& result) {
        if (node == nullptr) {
            return;
        }
        currentSum += node->val;
        path.push_back(node->val);
        if (node->left == nullptr && node->right == nullptr) {
            if (currentSum == target) {
                result.push_back(path);
            }
        } else {
            dfs(node->left, target, currentSum, path, result);
            dfs(node->right, target, currentSum, path, result);
        }
        path.pop_back();
    }
};
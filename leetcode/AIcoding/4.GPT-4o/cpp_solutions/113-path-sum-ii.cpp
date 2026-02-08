class Solution {
public:
    void dfs(TreeNode* node, int sum, vector<int>& path, vector<vector<int>>& result) {
        if (!node) return;
        path.push_back(node->val);
        sum -= node->val;
        if (!node->left && !node->right && sum == 0) {
            result.push_back(path);
        } else {
            dfs(node->left, sum, path, result);
            dfs(node->right, sum, path, result);
        }
        path.pop_back();
    }

    vector<vector<int>> pathSum(TreeNode* root, int sum) {
        vector<vector<int>> result;
        vector<int> path;
        dfs(root, sum, path, result);
        return result;
    }
};
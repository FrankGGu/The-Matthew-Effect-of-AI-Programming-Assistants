class Solution {
public:
    vector<vector<int>> pathSum(TreeNode* root, int targetSum) {
        vector<vector<int>> result;
        vector<int> path;
        dfs(root, targetSum, path, result);
        return result;
    }

private:
    void dfs(TreeNode* node, int sum, vector<int>& path, vector<vector<int>>& result) {
        if (!node) return;

        path.push_back(node->val);
        sum -= node->val;

        if (!node->left && !node->right && sum == 0) {
            result.push_back(path);
        }

        dfs(node->left, sum, path, result);
        dfs(node->right, sum, path, result);

        path.pop_back();
    }
};
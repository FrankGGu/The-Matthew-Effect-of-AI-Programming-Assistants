class Solution {
public:
    vector<vector<int>> pathSum(TreeNode* root, int sum) {
        vector<vector<int>> result;
        vector<int> path;
        findPaths(root, sum, path, result);
        return result;
    }

private:
    void findPaths(TreeNode* node, int sum, vector<int>& path, vector<vector<int>>& result) {
        if (!node) return;

        path.push_back(node->val);
        sum -= node->val;

        if (!node->left && !node->right && sum == 0) {
            result.push_back(path);
        } else {
            findPaths(node->left, sum, path, result);
            findPaths(node->right, sum, path, result);
        }

        path.pop_back();
    }
};
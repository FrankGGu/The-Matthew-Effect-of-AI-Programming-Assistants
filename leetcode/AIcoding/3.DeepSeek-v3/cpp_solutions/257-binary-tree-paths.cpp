class Solution {
public:
    vector<string> binaryTreePaths(TreeNode* root) {
        vector<string> res;
        if (!root) return res;
        dfs(root, "", res);
        return res;
    }

    void dfs(TreeNode* node, string path, vector<string>& res) {
        if (!node->left && !node->right) {
            path += to_string(node->val);
            res.push_back(path);
            return;
        }
        path += to_string(node->val) + "->";
        if (node->left) dfs(node->left, path, res);
        if (node->right) dfs(node->right, path, res);
    }
};
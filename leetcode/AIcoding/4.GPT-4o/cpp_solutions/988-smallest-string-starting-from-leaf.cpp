class Solution {
public:
    string smallestFromLeaf(TreeNode* root) {
        string result;
        dfs(root, "", result);
        return result;
    }

    void dfs(TreeNode* node, string path, string& result) {
        if (!node) return;
        path = char(node->val + 'a') + path;
        if (!node->left && !node->right) {
            if (result.empty() || path < result) {
                result = path;
            }
        }
        dfs(node->left, path, result);
        dfs(node->right, path, result);
    }
};
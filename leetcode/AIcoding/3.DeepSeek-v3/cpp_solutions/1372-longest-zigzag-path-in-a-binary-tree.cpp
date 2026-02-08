class Solution {
public:
    int max_len = 0;

    void dfs(TreeNode* node, bool is_left, int current_len) {
        if (!node) return;
        max_len = max(max_len, current_len);
        if (is_left) {
            dfs(node->right, false, current_len + 1);
            dfs(node->left, true, 1);
        } else {
            dfs(node->left, true, current_len + 1);
            dfs(node->right, false, 1);
        }
    }

    int longestZigZag(TreeNode* root) {
        dfs(root->left, true, 1);
        dfs(root->right, false, 1);
        return max_len;
    }
};
class Solution {
public:
    int max_len = 0;

    int longestUnivaluePath(TreeNode* root) {
        if (!root) {
            return 0;
        }
        dfs(root);
        return max_len;
    }

private:
    int dfs(TreeNode* node) {
        if (!node) {
            return 0;
        }

        int left_path_len = dfs(node->left);
        int right_path_len = dfs(node->right);

        int current_left_len = 0;
        if (node->left && node->left->val == node->val) {
            current_left_len = left_path_len + 1;
        }

        int current_right_len = 0;
        if (node->right && node->right->val == node->val) {
            current_right_len = right_path_len + 1;
        }

        max_len = std::max(max_len, current_left_len + current_right_len);

        return std::max(current_left_len, current_right_len);
    }
};
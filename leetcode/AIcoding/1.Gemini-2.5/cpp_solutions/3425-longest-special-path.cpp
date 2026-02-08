#include <algorithm>

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};

class Solution {
public:
    int max_len_global;

    int dfs(TreeNode* node) {
        if (!node) {
            return 0;
        }

        int left_path_len = dfs(node->left);
        int right_path_len = dfs(node->right);

        int current_left_branch_len = 0;
        if (node->left && node->left->val == node->val) {
            current_left_branch_len = 1 + left_path_len;
        }

        int current_right_branch_len = 0;
        if (node->right && node->right->val == node->val) {
            current_right_branch_len = 1 + right_path_len;
        }

        max_len_global = std::max(max_len_global, current_left_branch_len + current_right_branch_len);

        return std::max(current_left_branch_len, current_right_branch_len);
    }

    int longestUnivaluePath(TreeNode* root) {
        max_len_global = 0;
        dfs(root);
        return max_len_global;
    }
};
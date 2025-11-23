class Solution {
public:
    int left_subtree_size_of_x;
    int right_subtree_size_of_x;
    int target_x_val;

    int dfs(TreeNode* node) {
        if (!node) {
            return 0;
        }

        int left_count = dfs(node->left);
        int right_count = dfs(node->right);

        if (node->val == target_x_val) {
            left_subtree_size_of_x = left_count;
            right_subtree_size_of_x = right_count;
        }

        return 1 + left_count + right_count;
    }

    bool btreeGameWinningStrategy(TreeNode* root, int n, int x) {
        target_x_val = x;
        int total_nodes = dfs(root);

        int parent_component_size = total_nodes - 1 - left_subtree_size_of_x - right_subtree_size_of_x;

        if (left_subtree_size_of_x > n / 2 || right_subtree_size_of_x > n / 2 || parent_component_size > n / 2) {
            return true;
        }

        return false;
    }
};
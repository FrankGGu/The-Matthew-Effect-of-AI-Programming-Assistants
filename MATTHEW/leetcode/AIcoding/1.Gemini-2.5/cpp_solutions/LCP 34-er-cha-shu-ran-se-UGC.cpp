class Solution {
public:
    bool btreeGameWinningMove(TreeNode* root, int n, int x) {
        x_val = x;
        dfs(root);
        int parent_count = n - 1 - left_count - right_count;
        return std::max({parent_count, left_count, right_count}) > n / 2;
    }

private:
    int x_val;
    int left_count;
    int right_count;

    int dfs(TreeNode* node) {
        if (!node) {
            return 0;
        }

        int left_size = dfs(node->left);
        int right_size = dfs(node->right);

        if (node->val == x_val) {
            left_count = left_size;
            right_count = right_size;
        }

        return left_size + right_size + 1;
    }
};
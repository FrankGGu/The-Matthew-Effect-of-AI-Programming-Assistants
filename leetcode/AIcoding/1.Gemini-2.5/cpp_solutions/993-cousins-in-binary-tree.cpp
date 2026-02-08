class Solution {
public:
    int depth_x = -1;
    int depth_y = -1;
    TreeNode* parent_x = nullptr;
    TreeNode* parent_y = nullptr;

    void dfs(TreeNode* node, TreeNode* parent, int depth, int x, int y) {
        if (!node) {
            return;
        }

        if (node->val == x) {
            depth_x = depth;
            parent_x = parent;
        } else if (node->val == y) {
            depth_y = depth;
            parent_y = parent;
        }

        if (depth_x != -1 && depth_y != -1) {
            return;
        }

        dfs(node->left, node, depth + 1, x, y);
        if (depth_x != -1 && depth_y != -1) {
            return;
        }
        dfs(node->right, node, depth + 1, x, y);
    }

    bool isCousins(TreeNode* root, int x, int y) {
        dfs(root, nullptr, 0, x, y);
        return depth_x == depth_y && parent_x != parent_y;
    }
};
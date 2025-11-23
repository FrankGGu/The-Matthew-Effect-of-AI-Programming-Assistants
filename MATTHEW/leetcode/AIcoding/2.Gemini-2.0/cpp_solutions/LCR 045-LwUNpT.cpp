class Solution {
public:
    int findBottomLeftValue(TreeNode* root) {
        int bottomLeft = 0;
        int maxDepth = -1;

        function<void(TreeNode*, int)> dfs = [&](TreeNode* node, int depth) {
            if (!node) return;

            if (depth > maxDepth) {
                maxDepth = depth;
                bottomLeft = node->val;
            }

            dfs(node->left, depth + 1);
            dfs(node->right, depth + 1);
        };

        dfs(root, 0);
        return bottomLeft;
    }
};
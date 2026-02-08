class Solution {
public:
    TreeNode* lcaDeepestLeaves(TreeNode* root) {
        int maxDepth = 0;
        TreeNode* lca = nullptr;

        function<int(TreeNode*, int)> dfs = [&](TreeNode* node, int depth) {
            if (!node) return depth;

            int leftDepth = dfs(node->left, depth + 1);
            int rightDepth = dfs(node->right, depth + 1);

            if (leftDepth == rightDepth) {
                if (leftDepth >= maxDepth) {
                    maxDepth = leftDepth;
                    lca = node;
                }
            } else if (leftDepth > rightDepth) {

            } else {

            }

            return max(leftDepth, rightDepth);
        };

        dfs(root, 0);
        return lca;
    }
};
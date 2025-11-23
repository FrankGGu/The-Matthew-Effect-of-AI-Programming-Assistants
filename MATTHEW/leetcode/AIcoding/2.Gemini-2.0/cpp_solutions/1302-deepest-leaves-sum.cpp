class Solution {
public:
    int deepestLeavesSum(TreeNode* root) {
        int sum = 0;
        int maxDepth = 0;

        function<void(TreeNode*, int)> dfs = [&](TreeNode* node, int depth) {
            if (!node) return;

            if (!node->left && !node->right) {
                if (depth > maxDepth) {
                    maxDepth = depth;
                    sum = node->val;
                } else if (depth == maxDepth) {
                    sum += node->val;
                }
            }

            dfs(node->left, depth + 1);
            dfs(node->right, depth + 1);
        };

        dfs(root, 0);
        return sum;
    }
};